  import 'package:flutter/material.dart';

class TransaksiTerkiniPage extends StatelessWidget {
  final List<Map<String, String>> transaksiList = [
    {
      'jenis': 'Tagihan Penjualan (INV/00046)',
      'nama': 'CV Suwarno (Persero) Tbk Yance Titi Lailasari Mangunsong',
      'tanggal': '15/04/2025',
      'total': '1.348.649',
    },
    {
      'jenis': 'Tagihan Penjualan (INV/00046)',
      'nama': 'CV Suwarno (Persero) Tbk Yance Titi Lailasari Mangunsong',
      'tanggal': '15/04/2025',
      'total': '899.099',
    },
    {
      'jenis': 'Tagihan Pembelian (PI/00057)',
      'nama': 'UD Pradana Hendri Tamba Padmasari',
      'tanggal': '15/04/2025',
      'total': '538.739',
    },
    {
      'jenis': 'Tagihan Pembelian (PI/00057)',
      'nama': 'UD Pradana Hendri Tamba Padmasari',
      'tanggal': '15/04/2025',
      'total': '598.000',
    },
    {
      'jenis': 'Tagihan Penjualan (INV/00045)',
      'nama': 'PT Pradipta Rangga Prayoga Hidayanto',
      'tanggal': '14/04/2025',
      'total': '1.497.000',
    },
    {
      'jenis': 'Tagihan Pembelian (PI/00056)',
      'nama': 'PD Uwais Najmudin (Persero) Tbk Edward Gunawan Lestari',
      'tanggal': '14/04/2025',
      'total': '897.000',
    },
    {
      'jenis': 'Tagihan Penjualan (INV/00044)',
      'nama': 'Yayasan Haryanto Tbk Nova Mayasari Pudjiastuti',
      'tanggal': '11/04/2025',
      'total': '499.000',
    },
    {
      'jenis': 'Tagihan Penjualan (INV/00044)',
      'nama': 'Yayasan Haryanto Tbk Nova Mayasari Pudjiastuti',
      'tanggal': '11/04/2025',
      'total': '499.000',
    },
  ];

  TransaksiTerkiniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('Transaksi Terkini', style: TextStyle(color: Colors.blue[800])),
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
        itemCount: transaksiList.length,
        itemBuilder: (context, index) {
          final trx = transaksiList[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trx['jenis']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text('- ${trx['nama']!}', style: const TextStyle(fontSize: 13)),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(trx['tanggal']!, style: const TextStyle(fontSize: 12)),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(trx['total']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Icon(Icons.chevron_right),
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
