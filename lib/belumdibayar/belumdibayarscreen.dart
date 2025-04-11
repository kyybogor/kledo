import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/belumdibayar/detailbelumdibayar.dart';
import 'package:http/http.dart' as http;

class BelumDibayar extends StatefulWidget {
  const BelumDibayar({super.key});

  @override
  State<BelumDibayar> createState() => _BelumDibayarState();
}

class _BelumDibayarState extends State<BelumDibayar> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> invoices = [];
  List<Map<String, dynamic>> filteredInvoices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.55/connect/JSON/index.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        invoices = data.map<Map<String, dynamic>>((item) {
          return {
            "name": item["name"] ?? item["1"],
            "invoice": item["invoice"] ?? item["2"],
            "date": item["date"] ?? item["3"],
            "amount": item["amount"] ?? item["4"],
          };
        }).toList();

        setState(() {
          filteredInvoices = invoices;
          isLoading = false;
        });
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

  void _onSearchChanged() {
    String keyword = _searchController.text.toLowerCase();
    setState(() {
      filteredInvoices = invoices.where((invoice) {
        return invoice["name"].toString().toLowerCase().contains(keyword);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Belum Dibayar", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.blue),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.blue),
            onPressed: () {},
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("April 2025", style: TextStyle(fontWeight: FontWeight.bold)),
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.pink.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                invoice["amount"],
                                style: const TextStyle(color: Colors.pink),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detailbelumdibayar(invoice: invoice),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
