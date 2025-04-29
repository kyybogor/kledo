import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Detailkas extends StatefulWidget {
  final Map<String, dynamic> kasData;

  const Detailkas({super.key, required this.kasData});

  @override
  State<Detailkas> createState() => _DetailkasState();
}

class _DetailkasState extends State<Detailkas> {
  List<dynamic> transaksi = [];

  @override
  void initState() {
    super.initState();
    fetchTransaksi();
  }

  Future<void> fetchTransaksi() async {
    final kasId = widget.kasData['id'].toString();
    final url = Uri.parse("http://192.168.1.26/connect/JSON/transaksi.php");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Debug log
        print("Response data: $data");
        print("Kas ID: $kasId");

        // Gabungkan semua data dari berbagai jenis jika perlu
        List<dynamic> semuaTransaksi = [];
        if (data is Map<String, dynamic>) {
          semuaTransaksi = [
            ...?data['hayami'],
            ...?data['bank'],
          ];
        }

        final filtered = semuaTransaksi
            .where((item) =>
                item.containsKey('kas_id') &&
                item['kas_id'].toString() == kasId)
            .toList();

        setState(() {
          transaksi = filtered;
        });
      } else {
        print('Gagal mengambil data transaksi kas. Status: ${response.statusCode}');
      }
    } catch (e) {
      print("Error saat mengambil data kas: $e");
    }
  }

  double getTotalAmount() {
    double total = 0;
    for (var item in transaksi) {
      final jumlah = double.tryParse(item['amount'].toString());
      if (jumlah != null) {
        total += jumlah;
      }
    }
    return total;
  }

  String formatRupiah(double number) {
    final formatter = NumberFormat("#,###", "id_ID");
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.kasData;
    final nama = (data['nama'] ?? '-').split(':').last.trim();
    final tanggal = data['tanggal'] ?? '-';
    final status = data['status'] ?? 'Unreconciled';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kas"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(nama,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(status,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(tanggal, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          transaksi.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: Text("Tidak ada transaksi untuk kas ini.")),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: transaksi.length,
                          itemBuilder: (context, index) {
                            final item = transaksi[index];
                            double subtotal = 0;
                            for (int i = 0; i <= index; i++) {
                              subtotal += double.tryParse(transaksi[i]['amount'].toString()) ?? 0;
                            }
                            return Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    title: Text(item['subtitle'] ?? 'Tanpa Nama'),
                                    subtitle: Text(item['date'] ?? ''),
                                    trailing: Text(
                                      "Rp ${formatRupiah(double.tryParse(item['amount'].toString()) ?? 0)}",
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
                                    child: Text(
                                      "Subtotal: Rp ${formatRupiah(subtotal)}",
                                      style: const TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("Rp ${formatRupiah(getTotalAmount())}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
