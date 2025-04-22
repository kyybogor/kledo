import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/laporan/laporanscreen.dart';

class NeracaPage extends StatelessWidget {
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
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text("Neraca"),
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
              child: Text("assets" "22/04/2025",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ),
            SizedBox(height: 20),
            Text("Kas & Bank", style: boldStyle),
            buildItem("Kas", "28.900.519"),
            buildItem("Rekening Bank", "29.421.935"),
            buildItem("Giro", "30.456.920"),
            buildItem("Total Kas & Bank", "88.779.374", isBold: true),
            SizedBox(height: 20),
            Text("Aset Lancar", style: boldStyle),
            buildItem("Piutang Usaha", "50.342.590"),
            buildItem("Cadangan Kerugian Piutang", "10.125.780"),
            buildItem("Persediaan Barang", "18.123.000"),
            buildItem("Aset Lancar Lainnya", "10.811"),
            buildItem("PPN Masukan", "3.999.000"),
            buildItem("Total Aset Lancar", "83.151.682", isBold: true),
            SizedBox(height: 20),
            Text("Aset Tetap", style: boldStyle),
            buildItem("Aset Tetap-Tanah", "35.100.000"),
            buildItem("Aset Tak Berwujud", "(47.748)"),
            buildItem("Total Aset Tetap", "35.052.252", isBold: true),
            SizedBox(height: 20),
            Text("Depresiasi & Amortisasi", style: boldStyle),
            buildItem("Akumulasi Penyusutan-Mesin & Peralatan", "(52.252)"),
            buildItem("Total Depresiasi & Amortisasi", "(52.252)"),
            SizedBox(height: 20),
            Text("Lainnya", style: boldStyle),
            buildItem("Investasi", "(89.189)"),
            buildItem("Total Lainnya", "(89.189)"),
            SizedBox(height: 20),
            Text("Total Assets", style: boldStyle),
            buildItem("Total Assets", "206.841.867", isBold: true),
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
