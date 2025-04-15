import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Detailbelumdibayar extends StatefulWidget {
  final Map<String, dynamic> invoice;

  const Detailbelumdibayar({super.key, required this.invoice});

  @override
  State<Detailbelumdibayar> createState() => _DetailbelumdibayarState();
}

class _DetailbelumdibayarState extends State<Detailbelumdibayar> {
  List<dynamic> barang = [];

  @override
  void initState() {
    super.initState();
    fetchBarang();
  }

  Future<void> fetchBarang() async {
    final invoiceNumber = widget.invoice['invoice'];
    final url = Uri.parse("http://localhost/hayami/barang_invoice.php?invoice=$invoiceNumber");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          barang = data;
        });
      } else {
        print('Gagal mengambil data barang');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'belum dibayar':
        return Colors.red;
      case 'dibayar sebagian':
        return Colors.orange;
      case 'lunas':
        return Colors.green;
      case 'void':
        return Colors.grey;
      case 'jatuh tempo':
        return Colors.black;
      case 'retur':
        return Colors.deepOrange;
      case 'transaksi berulang':
        return Colors.blue;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;
    final contactName = invoice['name'] ?? 'Tidak diketahui';
    final invoiceNumber = invoice['invoice'] ?? '-';
    final date = invoice['date'] ?? '-';
    final dueDate = invoice['due'] ?? '-';
    final address = invoice['alamat'] ?? '-';
    final status = invoice['status'] ?? 'Belum Dibayar';
    final statusColor = _getStatusColor(status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildHeader(invoiceNumber, contactName, address, date, dueDate, status, statusColor),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Barang Dibeli", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: barang.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: barang.length,
                    itemBuilder: (context, index) {
                      final item = barang[index];
                      return Card(
                        child: ListTile(
                          title: Text(item['nama_barang']),
                          subtitle: Text("${item['jumlah']} x Rp ${item['harga']}"),
                          trailing: Text("Rp ${item['total']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String invoiceNumber, String contactName, String address, String date, String dueDate, String status, Color statusColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0052D4), Color(0xFF4364F7)],
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
          Text(invoiceNumber, style: const TextStyle(fontSize: 16, color: Colors.white70)),
          const SizedBox(height: 16),
          Text(contactName, style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(address, style: const TextStyle(fontSize: 13, color: Colors.white)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.6), shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(status, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(date, style: const TextStyle(color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(dueDate, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
