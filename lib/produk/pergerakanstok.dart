import 'package:flutter/material.dart';

class PergerakanStokPage extends StatelessWidget {
  final List<Map<String, String>> stokData = [
    {'judul': 'Tagihan Penjualan', 'tanggal': '15/04/2025', 'jumlah': '-3'},
    {'judul': 'Tagihan Penjualan', 'tanggal': '15/04/2025', 'jumlah': '-2'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '15/04/2025', 'jumlah': '+2'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '15/04/2025', 'jumlah': '+2'},
    {'judul': 'Tagihan Penjualan', 'tanggal': '14/04/2025', 'jumlah': '-3'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '14/04/2025', 'jumlah': '+3'},
    {'judul': 'Tagihan Penjualan', 'tanggal': '11/04/2025', 'jumlah': '-1'},
    {'judul': 'Tagihan Penjualan', 'tanggal': '11/04/2025', 'jumlah': '-1'},
    {'judul': 'Tagihan Penjualan', 'tanggal': '11/04/2025', 'jumlah': '-2'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '11/04/2025', 'jumlah': '+2'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '10/04/2025', 'jumlah': '+2'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '07/04/2025', 'jumlah': '+1'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '06/04/2025', 'jumlah': '+1.000'},
    {'judul': 'Tagihan Pembelian', 'tanggal': '06/04/2025', 'jumlah': '+1.000'},
  ];

  PergerakanStokPage({super.key});

  Color getColor(String jumlah) {
    return jumlah.contains('-')
        ? Colors.red.shade50
        : Colors.green.shade50;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title:
            Text('Pergerakan Stok', style: TextStyle(color: Colors.blue[800])),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue[800]),
      ),
      body: ListView.builder(
        itemCount: stokData.length,
        itemBuilder: (context, index) {
          final data = stokData[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            title: Text(data['judul']!,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(data['tanggal']!, style: const TextStyle(fontSize: 12)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 36,
                  decoration: BoxDecoration(
                    color: getColor(data['jumlah']!),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      data['jumlah']!, 
                      style: TextStyle(
                        color: data['jumlah']!.contains('-')
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () {
            },
          );
        },
      ),
    );
  }
}