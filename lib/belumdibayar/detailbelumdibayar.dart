import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Jangan lupa untuk mengimpor intl

class Detailbelumdibayar extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const Detailbelumdibayar({
    super.key,
    required this.invoice,
  });

  // Fungsi untuk format Rupiah
  String formatRupiah(String amount) {
    try {
      final double value = double.parse(amount);
      return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(value);
    } catch (e) {
      return 'Invalid amount';
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactName = invoice['name']?.toString() ?? 'Tidak diketahui';
    final invoiceNumber = invoice['invoice']?.toString() ?? '-';
    final date = invoice['date']?.toString() ?? '-';
    final amount = formatRupiah(invoice['amount']?.toString() ?? '0'); // Menggunakan formatRupiah

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tagihan'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "INVOICE DETAIL",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailTile(Icons.person, "Nama", contactName),
                _buildDetailTile(Icons.receipt_long, "Nomor Invoice", invoiceNumber),
                _buildDetailTile(Icons.date_range, "Tanggal", date),
                _buildDetailTile(Icons.attach_money, "Total", amount),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String label, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: Icon(icon, color: Colors.blue),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}
