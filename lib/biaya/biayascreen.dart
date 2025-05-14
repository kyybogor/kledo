import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Import halaman-halaman tujuan
import 'package:flutter_application_kledo/biaya/belumdibayarbiaya.dart';
import 'package:flutter_application_kledo/biaya/dibayarsebagianbiaya.dart';
import 'package:flutter_application_kledo/biaya/jatuhtempobiaya.dart';
import 'package:flutter_application_kledo/biaya/lunasbiaya.dart';
import 'package:flutter_application_kledo/biaya/transaksiberulangbiaya.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';

class BiayaPage extends StatefulWidget {
  const BiayaPage({super.key});

  @override
  State<BiayaPage> createState() => _BiayaPageState();
}

class _BiayaPageState extends State<BiayaPage> {
  bool _showChart = true;
  bool isLoading = true;

  Map<String, int> biayaCounts = {
    'Belum Dibayar': 0,
    'Dibayar Sebagian': 0,
    'Lunas': 0,
    'Jatuh Tempo': 0,
    'Transaksi Berulang': 0,
  };

  final Map<String, Color> kategoriColors = {
    'Belum Dibayar': Colors.pink,
    'Dibayar Sebagian': Colors.amber,
    'Lunas': Colors.green,
    'Jatuh Tempo': Colors.black,
    'Transaksi Berulang': Colors.blue,
  };

  final Map<String, String> statusEndpoints = {
    'Belum Dibayar': 'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=1',
    'Dibayar Sebagian': 'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=3',
    'Lunas': 'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=2',
    'Jatuh Tempo': 'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=4',
    'Transaksi Berulang': 'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=5',
  };

  final Map<String, Widget> kategoriPages = {
    'Belum Dibayar': const BelumDibayarBiaya(),
    'Dibayar Sebagian': const DibayarSebagianBiaya(),
    'Lunas': const LunasBiaya(),
    'Jatuh Tempo': const JatuhTempoBiaya(),
    'Transaksi Berulang': const TransaksiBerulangBiaya(),
  };

  @override
  void initState() {
    super.initState();
    fetchBiayaCounts();
  }

  Future<void> fetchBiayaCounts() async {
    setState(() {
      isLoading = true;
    });

    Map<String, int> newCounts = {
      for (var key in biayaCounts.keys) key: 0,
    };

    try {
      for (var entry in statusEndpoints.entries) {
        final response = await http.get(Uri.parse(entry.value));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          newCounts[entry.key] = data.length;
        }
      }

      setState(() {
        biayaCounts = newCounts;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
                _buildInfoCard('Belum Dibayar', '11.200.000', Colors.orange, '15'),
                _buildInfoCard('Jatuh Tempo', '11.200.000', Colors.green, '15'),
              ],
            ),
          ),
          const SizedBox(height: 16),

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
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                Icon(_showChart ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
          const SizedBox(height: 12),

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

          ...kategoriPages.keys.map((label) => _buildKategoriItem(
                label,
                kategoriColors[label] ?? Colors.grey,
                '${biayaCounts[label]}',
                kategoriPages[label],
              )),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String amount, Color color, String count) {
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
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
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
                  Text(amount,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
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

  Widget _buildKategoriItem(
      String title, Color color, String count, Widget? page) {
    return InkWell(
      onTap: page != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color, radius: 8),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(count, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
