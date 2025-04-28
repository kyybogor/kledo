import 'package:flutter/material.dart';

class ArusKasPage extends StatelessWidget {
  final TextStyle labelStyle = const TextStyle(fontSize: 16);
  final TextStyle valueStyle =
      const TextStyle(fontSize: 16, color: Colors.blue);
  final TextStyle boldStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  Widget buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      color: Colors.grey[200],
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildItem(String label, String value, {bool isBold = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: isBold ? boldStyle : labelStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            flex: 1,
            child: Text(
              value,
              style: isBold ? boldStyle : valueStyle,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Arus Kas"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80), // ruang untuk FAB
          child: ListView(
            children: [
              buildSectionHeader("Aktivitas Operasional"),
              buildItem("Penerimaan dari pelanggan", "40.976.110"),
              buildItem("Aset lancar lainnya", "(545.600)"),
              buildItem("Pembayaran ke pemasok", "(12.535.923)"),
              buildItem("Kartu kredit dan liabilitas jangka pendek lainnya",
                  "397.730"),
              buildItem("Pendapatan lain-lain", "0"),
              buildItem("Pembayaran biaya operasional", "(10.694.324)"),
              buildItem(
                  "Arus kas bersih dari aktivitas operasional", "17.597.993",
                  isBold: true),
              buildSectionHeader("Aktivitas Investasi"),
              buildItem("Perolehan/pembelian aset", "(47.748)"),
              buildItem("Aktivitas investasi lainnya", "89.189"),
              buildItem("Arus kas bersih dari aktivitas investasi", "136.937",
                  isBold: true),
              buildSectionHeader("Aktivitas Pendanaan"),
              buildItem("Liabilitas Jangka Panjang", "0"),
              buildItem("Modal Pemilik", "5.405"),
              buildItem("Arus kas bersih dari aktivitas pendanaan", "5.405",
                  isBold: true),
              buildSectionHeader("Total Arus Kas"),
              buildItem("Arus kas bersih", "17.740.335", isBold: true),
              buildSectionHeader("Kas dan Setara Kas"),
              buildItem("Kas dan setara kas di awal periode", "0"),
              buildItem("Kas dan setara kas di akhir periode", "0"),
              buildItem("Perubahan kas untuk periode", "0", isBold: true),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "share",
            child: const Icon(Icons.share),
            onPressed: () {},
            backgroundColor: Colors.blueAccent,
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "download",
            child: const Icon(Icons.download),
            onPressed: () {},
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
