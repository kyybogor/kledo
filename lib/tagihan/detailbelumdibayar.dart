import 'package:flutter/material.dart';

class Detailbelumdibayar extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const Detailbelumdibayar({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    // Gunakan key sesuai dengan data yang dikirim
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
                _buildDetailTile(Icons.attach_money, "Total", "Rp$amount"),
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
