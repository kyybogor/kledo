import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/kas%20&%20bank/detailkas.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class Kasscreen extends StatefulWidget {
  const Kasscreen({super.key});

  @override
  State<Kasscreen> createState() => _KasscreenState();
}

class _KasscreenState extends State<Kasscreen> {
  List<dynamic> transaksiHayami = [];
  List<dynamic> transaksiBank = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://192.168.1.5/connect/JSON/transaksi.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          transaksiHayami = data['hayami'];
          transaksiBank = data['bank'];
        });
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  String formatRupiah(dynamic amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    try {
      if (amount == null || amount.toString().isEmpty) return 'Rp 0';
      double value = double.tryParse(amount.toString()) ?? 0;
      return formatter.format(value);
    } catch (e) {
      return 'Rp 0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Kas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildInfoCard(
                        'Saldo', 'Rp 62,677,047', '+66,2%', Colors.green),
                    const SizedBox(width: 8),
                    _buildInfoCard(
                        'Masuk', 'Rp 25,000,000', '+45%', Colors.blue),
                    const SizedBox(width: 8),
                    _buildInfoCard(
                        'Keluar', 'Rp 10,000,000', '-12%', Colors.red),
                    const SizedBox(width: 8),
                    _buildInfoCard(
                        'Net', 'Rp 15,000,000', '-14%', Colors.black),
                  ],
                ),
              ),
            ),
            _buildSectionTitle("Transaksi di Hayami", () {}),
            ...transaksiHayami.map((item) => _buildHayamiTransactionItem(
                  title: item["title"] ?? "Judul tidak ada",
                  subtitle: item["subtitle"] ?? "Tidak ada nama",
                  date: item["date"] ?? "-",
                  amount: item["amount"] ?? "0",
                )),
            _buildSectionTitle("Transaksi di Bank", () {}),
            ...transaksiBank.map((item) => _buildBankTransactionItem(
                  title: item["title"] ?? "-",
                  subtitle: item["subtitle"] ?? "-",
                  date: item["date"] ?? "-",
                  amount: item["amount"] ?? "0",
                  isKirim:
                      (item["subtitle"]?.toLowerCase() ?? "") == "kirim dana",
                  reconciled: item["status"] == "Reconciled",
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String value, String change, Color color) {
    bool isNegative = change.startsWith('-');
    return SizedBox(
      width: 220,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (change.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        isNegative ? Icons.trending_down : Icons.trending_up,
                        size: 16,
                        color: color,
                      ),
                      const SizedBox(width: 4),
                      Text(change,
                          style: TextStyle(color: color, fontSize: 13)),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: onTap,
            child:
                const Text("Lihat Semua", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
    );
  }

  Widget _buildHayamiTransactionItem({
  required String title,
  required String subtitle,
  required String date,
  required String amount,
}) {
  final kasData = {
    'id': '1', // contoh ID kas Hayami
    'nama': "Terima pembayaran tagihan: $title", // tambahkan prefix di sini
    'tanggal': date,
    'status': 'Reconciled',
  };

  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detailkas(kasData: kasData),
        ),
      );
    },
    title: Text(
      "Terima pembayaran tagihan: $title", // tambahkan prefix di sini
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subtitle, style: const TextStyle(fontSize: 12)),
        Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            formatRupiah(amount),
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildBankTransactionItem({
    required String title,
    required String subtitle,
    required String date,
    required String amount,
    required bool isKirim,
    required bool reconciled,
  }) {
    Color amountColor = isKirim ? Colors.red : Colors.green;
    Color statusColor = reconciled ? Colors.green : Colors.red;
    String statusText = reconciled ? "Reconciled" : "Unreconciled";

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: subtitle.toLowerCase() == "kirim dana"
            ? Colors.red[50]
            : Colors.green[50],
        child: Icon(
          subtitle.toLowerCase() == "kirim dana"
              ? Icons.trending_down
              : Icons.trending_up,
          color: subtitle.toLowerCase() == "kirim dana"
              ? Colors.red
              : Colors.green,
        ),
      ),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: const TextStyle(fontSize: 12)),
          Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: amountColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(formatRupiah(amount),
                style: TextStyle(color: amountColor)),
          ),
          const SizedBox(height: 4),
          Text(statusText, style: TextStyle(color: statusColor, fontSize: 12)),
        ],
      ),
    );
  }
}
