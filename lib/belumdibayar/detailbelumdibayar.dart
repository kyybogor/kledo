import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Detailbelumdibayar extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const Detailbelumdibayar({
    super.key,
    required this.invoice,
  });

  Future<void> _deleteInvoice(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin menghapus pelanggan ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.102/connect/JSON/delete.php'),
        body: {'invoice': invoice['invoice']},
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pelanggan berhasil dihapus")),
        );
        Navigator.pop(context, true); // Kembali dan beri sinyal ke halaman sebelumnya
      } else {
        throw Exception(data['message'] ?? 'Gagal menghapus data');
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat menghapus data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactName = invoice['name']?.toString() ?? 'Tidak diketahui';
    final invoiceNumber = invoice['invoice']?.toString() ?? '-';
    final date = invoice['date']?.toString() ?? '-';
    final amount = invoice['amount']?.toString() ?? '0';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tagihan'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteInvoice(context),
          ),
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
