import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/laporan/laporanscreen.dart';

class LabaRugiPage extends StatelessWidget {
  final TextStyle labelStyle = TextStyle(fontSize: 16);
  final TextStyle valueStyle = TextStyle(fontSize: 16, color: Colors.blue);
  final TextStyle boldStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  Widget buildSectionHeader(String title) {
    return Container(
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
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: isBold ? boldStyle : labelStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              style: isBold ? boldStyle : valueStyle,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
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
        title: const Text("Laba Rugi"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          buildSectionHeader("Pendapatan Perdagangan"),
          buildItem("(4-40100) Diskon Penjualan", "33.333"),
          buildItem("(4-40000) Pendapatan", "126.492.027"),
          buildItem("(7-70101) Biaya Tambahan Pelanggan", "(15.315)"),
          buildItem("(7-70001) Pendapatan Bunga - Deposito", "59.459"),
          buildItem("Total Pendapatan Perdagangan", "126.569.505",
              isBold: true),
          buildSectionHeader("Beban Pokok Penjualan"),
          buildItem("(5-50000) Beban Pokok Pendapatan", "39.361.323"),
          buildItem("(5-50400) Biaya Impor", "(52.252)"),
          buildItem("(5-50300) Pengiriman & Pengangkutan", "(50.450)"),
          buildItem("Total Beban Pokok", "39.264.090", isBold: true),
          buildItem("Laba Kotor", "87.305.414", isBold: true),
          buildSectionHeader("Biaya Operasional"),
          buildItem("(6-60301) Alat Tulis Kantor & Printing", "29.730"),
          buildItem("(6-60300) Beban Kantor", "(17.117)"),
          buildItem("(6-60003) Bensin, Tol dan Parkir Penjualan", "9.565.225"),
          buildItem("(6-60219) IPL", "(61.261)"),
          buildItem("(6-60001) Iklan & Promosi", "8.207.027"),
          buildItem("(6-60108) Insentif", "(1.802)"),
          buildItem("(6-60107) Jamsostek", "74.775"),
          buildItem("(6-60002) Komisi & Fee", "8.918.829"),
          buildItem("(6-60005) Komunikas - Penjualan", "4.532.523"),
          buildItem("(6-60209) Legal & Profesional", "18.018"),
          buildItem("(6-60205) Makanan", "(41.441)"),
          buildItem("(6-60305) Pemborong", "89.189"),
          buildItem("(6-60216) Pengeluaran Barang Rusak", "10.811"),
          buildItem("(6-60502) Penyusutan - Kendaraan", "(77.477)"),
          buildItem("(6-60004) Perjalanan Dinas - Penjualan", "9.713.694"),
          buildItem("(6-60204) Perjalanan Dinas - Umum", "10.811"),
          buildItem("(6-60106) THR & Bonus", "40.541"),
          buildItem("(9-90000) Beban Pajak - Kini", "63.964"),
          buildItem("(8-81002) Laba/Rugi Selisih Kurs - Belum Direalisasikan",
              "39.640"),
          buildItem("(8-80100) Penyesuaian Persediaan", "(3.427.900)"),
          buildItem("Total Biaya Operasional", "37.687.776", isBold: true),
          buildSectionHeader("Laba Bersih"),
          buildItem("Laba Bersih", "49.617.639", isBold: true),
        ],
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
