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
  double totalSeluruhAmount = 0.0;

  @override
  void initState() {
    super.initState();
    fetchTransaksi();
  }

  Future<void> fetchTransaksi() async {
    final kasId = widget.kasData['id']?.toString() ?? '';
    final url = Uri.parse("http://192.168.1.9/connect/JSON/transaksi.php");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> semuaTransaksi = [];

        if (data is Map<String, dynamic>) {
          semuaTransaksi = [
            ...?data['hayami'],
            ...?data['bank'],
          ];

          // Hitung total semua amount dari seluruh data
          totalSeluruhAmount = semuaTransaksi.fold(0.0, (total, item) {
            final amount = double.tryParse(item['amount']?.toString() ?? '') ?? 0.0;
            return total + amount;
          });

          // Filter data hanya untuk kas_id terkait
          final filtered = semuaTransaksi
              .where((item) => item['kas_id']?.toString() == kasId)
              .toList();

          setState(() {
            transaksi = filtered;
          });
        }
      } else {
        debugPrint('Gagal mengambil data transaksi. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error saat mengambil data transaksi: $e");
    }
  }

  double getTotalAmount() {
    return transaksi.fold(0.0, (total, item) {
      final amount = double.tryParse(item['amount']?.toString() ?? '') ?? 0.0;
      return total + amount;
    });
  }

  String formatRupiah(double number) {
    final formatter = NumberFormat("#,###", "id_ID");
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.kasData;
    final nama = (data['nama'] ?? '-').toString().split(':').last.trim();
    final instansi = data['instansi']?.toString() ?? '-';
    final tanggal = data['tanggal']?.toString() ?? '-';
    final status = data['status']?.toString() ?? 'Unreconciled';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kas"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
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
            padding: const EdgeInsets.all(20),
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
                Text(instansi, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(status,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(tanggal, style: const TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Total Semua Transaksi: Rp ${formatRupiah(totalSeluruhAmount)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: transaksi.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Tidak ada transaksi untuk kas ini."),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: transaksi.length,
                          itemBuilder: (context, index) {
                            final item = transaksi[index];
                            final jumlah =
                                double.tryParse(item['amount']?.toString() ?? '') ?? 0;

                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                title: Text(item['title'] ?? '-'),
                                subtitle: Text(item['date'] ?? ''),
                                trailing: Text(
                                  "Rp ${formatRupiah(jumlah)}",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
                            const Text("Total Transaksi Kas Ini",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text("Rp ${formatRupiah(getTotalAmount())}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Tambahkan fungsi share jika dibutuhkan
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.share),
      ),
    );
  }
}
