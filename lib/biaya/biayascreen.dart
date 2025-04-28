import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';

// Import halaman-halaman tujuan
import 'package:flutter_application_kledo/biaya/belumdibayarbiaya.dart';
import 'package:flutter_application_kledo/biaya/dibayarsebagianbiaya.dart';
import 'package:flutter_application_kledo/biaya/jatuhtempobiaya.dart';
import 'package:flutter_application_kledo/biaya/lunasbiaya.dart';
import 'package:flutter_application_kledo/biaya/transaksiberulangbiaya.dart';
class BiayaPage extends StatefulWidget {
  const BiayaPage({super.key});

  @override
  State<BiayaPage> createState() => _BiayaPageState();
}

class _BiayaPageState extends State<BiayaPage> {
  bool _showChart = true;

  final Map<String, Color> kategoriColors = {
    'Belum Dibayar': Colors.pink,
    'Dibayar Sebagian': Colors.amber,
    'Lunas': Colors.green,
    'Jatuh Tempo': Colors.black,
    'Transaksi Berulang': Colors.blue,
  };

  final Map<String, Widget> kategoriPages = {
    'Belum Dibayar': const BelumDibayarBiaya(),
    'Dibayar Sebagian': const DibayarSebagianBiaya(),
    'Lunas': const LunasBiaya(),
    'Jatuh Tempo': const JatuhTempoBiaya(),
    'Transaksi Berulang': const TransaksiBerulangBiaya(),
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const KledoDrawer(),
      appBar: AppBar(
        title: const Text('Biaya'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambah aksi jika diperlukan
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Cari',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 12),

          // Info Cards - Horizontal Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildInfoCard('Bulan Ini', '16.042.100', Colors.amber, '18'),
                _buildInfoCard('30 Hari Lalu', '23.353.200', Colors.pink, '27'),
                _buildInfoCard('Bulan Sebelumnya', '11.200.000', Colors.blue, '15'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // "Lihat Selengkapnya"
          InkWell(
            onTap: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showChart ? 'Sembunyikan' : 'Lihat Selengkapnya',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                Icon(_showChart ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Multiple Charts - Fullscreen Width Scroll
          if (_showChart)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  2,
                  (index) => _buildChartCard(index + 1, screenWidth),
                ),
              ),
            ),
          if (_showChart) const SizedBox(height: 16),

          // Kategori List
          ...kategoriPages.keys.map((label) => _buildKategoriItem(
                label,
                kategoriColors[label] ?? Colors.grey,
                '20', // Ganti dengan jumlah dinamis jika perlu
                kategoriPages[label],
              )),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String amount, Color color, String count) {
    return Container(
      width: 220,
      height: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(int index, double width) {
    return Container(
      width: width - 100,
      height: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Chart $index',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildKategoriItem(String title, Color color, String count, Widget? page) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color, radius: 8),
      title: Text(title),
      trailing: Text(count),
      onTap: page != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          : null,
    );
  }
}
