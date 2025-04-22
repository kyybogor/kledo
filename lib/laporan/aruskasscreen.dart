import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/laporan/laporanscreen.dart';

class ArusKasPage extends StatelessWidget {
  final TextStyle labelStyle = TextStyle(fontSize: 16);
  final TextStyle valueStyle = TextStyle(fontSize: 16, color: Colors.blue);
  final TextStyle boldStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  Widget buildItem(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold ? boldStyle : labelStyle),
          Text(value, style: isBold ? boldStyle : valueStyle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Arus Kas"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text("Aktivitas Operasional",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ),
            SizedBox(height: 20),
            Text("Aktivitas Operasional", style: boldStyle),
            buildItem("Penerimaan dari pelanggan", "40.976.110"),
            buildItem("Aset lancar lainnya", "(545.600)"),
            buildItem("Pembayaran ke pemasok", "(12.535.923)"),
            buildItem(
                "Kartu kredit dan liabilitas jangka pendek lainnya", "397.730"),
            buildItem("Pendapatan lain-lain", "0"),
            buildItem("Pembayaran biaya operasional", "(10.694.324)"),
            buildItem(
                "Arus kas bersih dari aktivitas operasional", "17.597.993",
                isBold: true),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Aktivitas Investasi",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ),
            SizedBox(height: 20),
            Text("Aktivitas Investasi", style: boldStyle),
            buildItem("Perolehan/pembelian aset", "(47.748)"),
            buildItem("Aktivitas investasi lainnya", "89.189"),
            buildItem("Arus kas bersih dari aktivitas investasi", "136.937",
                isBold: true),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Aktivitas Pendanaan",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ),
            SizedBox(height: 20),
            Text("Aktivitas Pendanaan", style: boldStyle),
            buildItem("Liabilitas Jangka Panjang", "0"),
            buildItem("Modal Pemilik", "5.405"),
            buildItem("Arus kas bersih dari aktivitas pendanaan", "5.405",
                isBold: true),
            SizedBox(height: 20),
            buildItem("Arus kas bersih", "17.740.335", isBold: true),
            SizedBox(height: 20),
            Text("Kas dan Setara Kas", style: boldStyle),
            buildItem("Kas dan setara kas di awal periode", "0"),
            buildItem("Kas dan setara kas di akhir periode", "0"),
            buildItem("Perubahan kas untuk periode", "0", isBold: true),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "share",
            child: Icon(Icons.share),
            onPressed: () {},
            backgroundColor: Colors.blueAccent,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "download",
            child: Icon(Icons.download),
            onPressed: () {},
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
