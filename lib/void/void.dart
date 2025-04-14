import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/belumdibayar/detailbelumdibayar.dart';
import 'package:flutter_application_kledo/tagihan/tambahtagihan.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Void extends StatefulWidget {
  const Void({super.key});

  @override
  State<Void> createState() => _VoidState();
}

class _VoidState extends State<Void> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> invoices = [];
  List<Map<String, dynamic>> filteredInvoices = [];
  bool isLoading = true;
  bool dataChanged = false;

  String selectedMonth = DateFormat('MM').format(DateTime.now());
  String selectedYear = DateFormat('yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    try {
      final response = await http.get(Uri.parse(
          'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=4'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        invoices = data.map<Map<String, dynamic>>((item) {
          return {
            "name": item["nama"] ?? item["1"],
            "invoice": item["invoice"] ?? item["2"],
            "date": item["date"] ?? item["3"],
            "amount": item["amount"] ?? item["4"],
          };
        }).toList();

        setState(() {
          isLoading = false;
        });

        filterByMonthYear();
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterByMonthYear() {
    setState(() {
      filteredInvoices = invoices.where((invoice) {
        try {
          final invoiceDate = DateFormat('yyyy-MM-dd').parse(invoice["date"]);
          return invoiceDate.month.toString().padLeft(2, '0') == selectedMonth &&
              invoiceDate.year.toString() == selectedYear;
        } catch (e) {
          return false;
        }
      }).toList();
    });
  }

  Future<void> deleteInvoice(Map<String, dynamic> invoice) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.102/connect/JSON/delete.php'),
        body: {
          'invoice': invoice['invoice'],
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          invoices.removeWhere((item) => item['invoice'] == invoice['invoice']);
          filteredInvoices.removeWhere((item) => item['invoice'] == invoice['invoice']);
          dataChanged = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil dihapus")),
        );
      } else {
        throw Exception("Gagal menghapus data");
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghapus data")),
      );
    }
  }

  void _onSearchChanged() {
    String keyword = _searchController.text.toLowerCase();
    setState(() {
      filteredInvoices = invoices.where((invoice) {
        final invoiceDate = DateFormat('yyyy-MM-dd').parse(invoice["date"]);
        return invoice["name"].toString().toLowerCase().contains(keyword) &&
            invoiceDate.month.toString().padLeft(2, '0') == selectedMonth &&
            invoiceDate.year.toString() == selectedYear;
      }).toList();
    });
  }

  String formatRupiah(String amount) {
    try {
      final double value = double.parse(amount);
      return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
          .format(value);
    } catch (e) {
      return amount;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, dataChanged);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Belum Dibayar", style: TextStyle(color: Colors.blue)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.pop(context, dataChanged);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_alt_outlined, color: Colors.blue),
              onPressed: () {
                // Optional: open dialog or show options
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Cari",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: selectedMonth,
                    items: List.generate(12, (index) {
                      final month = (index + 1).toString().padLeft(2, '0');
                      return DropdownMenuItem(
                        value: month,
                        child: Text(DateFormat('MMMM').format(DateTime(0, index + 1))),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedMonth = value;
                        });
                        filterByMonthYear();
                      }
                    },
                  ),
                  DropdownButton<String>(
                    value: selectedYear,
                    items: ['2023', '2024', '2025'].map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedYear = value;
                        });
                        filterByMonthYear();
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredInvoices.isEmpty
                      ? const Center(child: Text("Tidak ada data ditemukan"))
                      : ListView.builder(
                          itemCount: filteredInvoices.length,
                          itemBuilder: (context, index) {
                            final invoice = filteredInvoices[index];
                            return ListTile(
                              title: Text(invoice["name"]),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(invoice["invoice"]),
                                  Text(invoice["date"]),
                                ],
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  formatRupiah(invoice["amount"]),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Detailbelumdibayar(invoice: invoice),
                                  ),
                                );

                                if (result == true) {
                                  fetchInvoices();
                                  dataChanged = true;
                                }
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Hapus Data"),
                                    content: const Text(
                                        "Yakin ingin menghapus data ini?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text("Batal"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteInvoice(invoice);
                                        },
                                        child: const Text("Hapus"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TambahInvoice()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}