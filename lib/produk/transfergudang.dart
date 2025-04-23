import 'package:flutter/material.dart';

class TransferGudangPage extends StatelessWidget {
  final List<Map<String, String>> transfers = [
    {'kode': 'WT/00004', 'tanggal': '09/03/2025'},
    {'kode': 'WT/00003', 'tanggal': '08/03/2025'},
    {'kode': 'WT/00002', 'tanggal': '07/03/2025'},
    {'kode': 'WT/00001', 'tanggal': '06/03/2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('Transfer Gudang', style: TextStyle(color: Colors.blue[800])),
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
        itemCount: transfers.length,
        itemBuilder: (context, index) {
          final transfer = transfers[index];
          return ListTile(
            title: Text(transfer['kode']!),
            subtitle: Text(transfer['tanggal']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
            },
          );
        },
      ),
    );
  }
}
