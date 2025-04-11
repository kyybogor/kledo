import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Import semua halaman tujuan
import 'package:flutter_application_kledo/belumdibayar/belumdibayarscreen.dart';
import 'package:flutter_application_kledo/dibayarsebagian/dibayarsebagian.dart';

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  int belumDibayarCount = 0;
  bool isLoading = true;

  final List<Map<String, dynamic>> staticTagihanList = const [
    {"label": "Dibayar Sebagian", "count": 1, "color": Colors.amber},
    {"label": "Lunas", "count": 19, "color": Colors.green},
    {"label": "Void", "count": 0, "color": Colors.grey},
    {"label": "Jatuh Tempo", "count": 0, "color": Colors.black},
    {"label": "Retur", "count": 0, "color": Colors.orange},
    {"label": "Transaksi Berulang", "count": 0, "color": Colors.blue},
  ];

  @override
  void initState() {
    super.initState();
    fetchBelumDibayarCount();
  }

  Future<void> fetchBelumDibayarCount() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.102/connect/JSON/index.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          belumDibayarCount = data.length;
          isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fungsi untuk memetakan label ke halaman tujuan
  Widget? getTargetPage(String label) {
    switch (label) {
      case "Dibayar Sebagian":
        return const Dibayarsebagian();
      case "Lunas":
        //return const LunasPage();
      case "Void":
        //return const VoidPage();
      case "Jatuh Tempo":
        //return const JatuhTempoPage();
      case "Retur":
        //return const ReturPage();
      case "Transaksi Berulang":
        //return const TransaksiBerulangPage();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(), // Ganti dengan drawer custom kamu jika perlu
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Tagihan", style: TextStyle(color: Colors.blue)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: 10,
                        ),
                        title: const Text("Belum Dibayar"),
                        trailing: Text("$belumDibayarCount"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BelumDibayar(),
                            ),
                          ).then((value) {
                            if (value == true) {
                              fetchBelumDibayarCount();
                            }
                          });
                        },
                      ),
                      const Divider(height: 1),
                      ...staticTagihanList.map((item) {
                        final page = getTargetPage(item['label']);
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: item['color'],
                                radius: 10,
                              ),
                              title: Text(item['label']),
                              trailing: Text("${item['count']}"),
                              onTap: page != null
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => page),
                                      );
                                    }
                                  : null,
                            ),
                            const Divider(height: 1),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
