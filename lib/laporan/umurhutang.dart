import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(home: UmurHutangPage()));

class UmurHutangPage extends StatefulWidget {
  @override
  State<UmurHutangPage> createState() => _UmurHutangPageState();
}

class _UmurHutangPageState extends State<UmurHutangPage> {
  List<Map<String, dynamic>> dataHutang = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.13/CONNNECT/JSON/get_umur_hutang.php')); // Ganti dengan IP lokal kamu
    if (response.statusCode == 200) {
      setState(() {
        dataHutang =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatRupiah(int amount) {
    return amount
        .toString()
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
  }

  int getTotal() {
    return dataHutang.fold(
        0,
        (sum, item) =>
            sum + (item['umur'] as List).fold(0, (a, b) => a + b) as int);
  }

  @override
  Widget build(BuildContext context) {
    final total = getTotal();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Umur Hutang', style: TextStyle(color: Colors.blue)),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: fetchData,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: dataHutang.length + 1,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index < dataHutang.length) {
                  final item = dataHutang[index];
                  final totalIndividu =
                      (item['umur'] as List).fold(0, (a, b) => a + b as int);
                  return ListTile(
                    title: Text(item['nama']),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        formatRupiah(totalIndividu),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailUmurHutangPage(
                            nama: item['nama'],
                            umur: List<int>.from(item['umur']),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return ListTile(
                    title: const Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        formatRupiah(total),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}

class DetailUmurHutangPage extends StatelessWidget {
  final String nama;
  final List<int> umur;

  DetailUmurHutangPage({required this.nama, required this.umur});

  final List<String> kategori = const [
    "< 1 Bulan",
    "1 s/d <= 2 bulan",
    "2 s/d <= 3 bulan",
    "3 s/d <= 4 bulan",
    "> 4 bulan"
  ];

  String formatRupiah(int amount) {
    return amount
        .toString()
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
  }

  @override
  Widget build(BuildContext context) {
    final total = umur.fold(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          nama.length > 20 ? '${nama.substring(0, 20)}...' : nama,
          style: const TextStyle(color: Colors.blue),
        ),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Umur Hutang',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: umur.length + 1,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index < umur.length) {
                  return ListTile(
                    title: Text(kategori[index]),
                    trailing: Text(
                      formatRupiah(umur[index]),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  );
                } else {
                  return ListTile(
                    title: const Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(
                      formatRupiah(total),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
