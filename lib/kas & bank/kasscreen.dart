import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Kasscreen extends StatefulWidget {
  const Kasscreen({super.key});

  @override
  State<Kasscreen> createState() => _KasscreenState();
}

class _KasscreenState extends State<Kasscreen> {
  List<dynamic> transaksi = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          transaksi = data;
        });
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
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
                    _buildInfoCard('Saldo', 'Rp 62,677,047', '+66,2%', Colors.green),
                    const SizedBox(width: 8),
                    _buildInfoCard('Masuk', 'Rp 25,000,000', '+45%', Colors.blue),
                    const SizedBox(width: 8),
                    _buildInfoCard('Keluar', 'Rp 10,000,000', '-12%', Colors.red),
                    const SizedBox(width: 8),
                    _buildInfoCard('Net', 'Rp 15,000,000', '-14%', Colors.black),
                  ],
                ),
              ),
            ),

            _buildSectionTitle("Transaksi di Hayami", () {}),

            // Tampilkan data dari API
            ...transaksi.map((item) => _buildTransactionItem(
                  title: item["title"] ?? "Judul tidak ada",
                  subtitle: item["subtitle"] ?? "Tidak ada nama",
                  date: item["date"] ?? "-",
                  amount: item["amount"] ?? "0",
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

Widget _buildInfoCard(String title, String value, String change, Color color) {
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
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                    Text(
                      change,
                      style: TextStyle(color: color, fontSize: 13),
                    ),
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
            child: const Text(
              "Lihat Semua",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String subtitle,
    required String date,
    required String amount,
  }) {
    return ListTile(
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
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(amount, style: const TextStyle(color: Colors.green)),
          ),
          const SizedBox(height: 4),
          const Text("Unreconciled",
              style: TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }
}
