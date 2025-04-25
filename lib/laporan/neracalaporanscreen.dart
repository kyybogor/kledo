import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/laporan/laporanscreen.dart';

class NeracaPage extends StatelessWidget {
  final TextStyle labelStyle = const TextStyle(fontSize: 16);
  final TextStyle valueStyle =
      const TextStyle(fontSize: 16, color: Colors.blue);
  final TextStyle boldStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  Widget buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget buildItem(String label, String value, {bool isBold = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
          const SizedBox(width: 10),
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
        title: const Text("Neraca"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              color: Colors.yellow[100],
              padding: const EdgeInsets.all(12),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    const TextSpan(
                        text:
                            "Data yang tampil saat ini adalah data dummy. Setelah Anda siap, "),
                    TextSpan(
                      text: "klik disini",
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                    const TextSpan(text: " untuk mengosongkan data."),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("Assets 25/04/2025",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ),
            const SizedBox(height: 10),
            buildSectionHeader("Kas & Bank"),
            buildItem("Kas", "28.900.519"),
            buildItem("Rekening Bank", "29.421.935"),
            buildItem("Giro", "30.456.920"),
            buildItem("Total Kas & Bank", "88.779.374", isBold: true),
            buildSectionHeader("Aset Lancar"),
            buildItem("Piutang Usaha", "50.342.590"),
            buildItem("Cadangan Kerugian Piutang", "10.125.780"),
            buildItem("Persediaan Barang", "18.123.000"),
            buildItem("Aset Lancar Lainnya", "10.811"),
            buildItem("PPN Masukan", "3.999.000"),
            buildItem("Total Aset Lancar", "83.151.682", isBold: true),
            buildSectionHeader("Aset Tetap"),
            buildItem("Aset Tetap-Tanah", "35.100.000"),
            buildItem("Aset Tak Berwujud", "(47.748)"),
            buildItem("Total Aset Tetap", "35.052.252", isBold: true),
            buildSectionHeader("Depresiasi & Amortisasi"),
            buildItem("Akumulasi Penyusutan-Mesin & Peralatan", "(52.252)"),
            buildItem("Total Depresiasi & Amortisasi", "(52.252)",
                isBold: true),
            buildSectionHeader("Lainnya"),
            buildItem("Investasi", "(89.189)"),
            buildItem("Total Lainnya", "(89.189)", isBold: true),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("Total Assets 206.841.867", style: boldStyle),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("Liabilitas & Modal 25/04/2025",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ),
            const SizedBox(height: 10),
            buildSectionHeader("Liabilitas Jangka Pendek"),
            buildItem("Hutang Usaha", "42.879.684"),
            buildItem("Hutang Belum Ditagih", "8.499.009"),
            buildItem("Hutang Deviden", "(44.144)"),
            buildItem("Pendapatan Diterima Di Muka", "1.802"),
            buildItem("PPN Keluaran", "13.095.085"),
            buildItem("Hutang Pajak-PPh 22", "(34.234)"),
            buildItem("Hutang Pajak-PPh 29", "(63.964)"),
            buildItem("Kewajiban Lancar Lainnya", "45.946"),
            buildItem("Total Liabilitas Jangka Pendek", "64.379.184",
                isBold: true),
            buildSectionHeader("Liabilitas Jangka Panjang"),
            buildItem("Total Liabilitas Jangka Panjang", "0"),
            buildSectionHeader("Perubahan Modal"),
            buildItem("Modal Saham", "92.757.658"),
            buildItem("Tambahan Modal Disetor", "5.405"),
            buildItem("Laba ditahan", "81.982"),
            buildItem("Pendapatan Sampai Periode Terakhir", "0"),
            buildItem("Pendapatan Periode Ini", "49.617.639"),
            buildItem("total Perubahan Modal", "142.462.684"),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("Total Liabilitas & Modal 206.841.867",
                  style: boldStyle),
            ),
          ],
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
