import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Pembelian/belumdibayarpembelian.dart';
import 'package:flutter_application_kledo/Pembelian/dibayarsebagianpembelian.dart';
import 'package:flutter_application_kledo/Pembelian/lunaspembelian.dart';
import 'package:flutter_application_kledo/Pembelian/pembelianscreen.dart';
import 'package:flutter_application_kledo/Pembelian/voidpembelian.dart';
import 'package:http/http.dart' as http;

class TagihanPembelianPage extends StatefulWidget {
  const TagihanPembelianPage({super.key});

  @override
  State<TagihanPembelianPage> createState() => _TagihanPembelianPageState();
}

class _TagihanPembelianPageState extends State<TagihanPembelianPage> {
  Map<String, int> tagihanCounts = {
    "Belum Dibayar": 0,
    "Dibayar Sebagian": 0,
    "Lunas": 0,
    "Void": 0,
    "Jatuh Tempo": 0,
    "Retur": 0,
    "Transaksi Berulang": 0,
  };

  bool isLoading = true;

  final Map<String, Color> statusColors = {
    "Belum Dibayar": Colors.pink,
    "Dibayar Sebagian": Colors.amber,
    "Lunas": Colors.green,
    "Void": Colors.grey,
    "Jatuh Tempo": Colors.black,
    "Retur": Colors.orange,
    "Transaksi Berulang": Colors.blue,
  };

  final Map<String, String> statusEndpoints = {
    "Belum Dibayar":
        'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=1',
    "Dibayar Sebagian":
        'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=3',
    "Lunas": 'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=2',
    "Void": 'https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=4',
    // Tambahkan endpoint lain jika ada untuk status lainnya
  };

  @override
  void initState() {
    super.initState();
    fetchTagihanCounts();
  }

  Future<void> fetchTagihanCounts() async {
    setState(() {
      isLoading = true;
    });

    Map<String, int> newCounts = {
      for (var key in tagihanCounts.keys) key: 0,
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
        tagihanCounts = newCounts;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget? getTargetPage(String label) {
    switch (label) {
      case "Belum Dibayar":
        return const BelumDibayarPembelian();
      case "Dibayar Sebagian":
        return const DibayarSebagianPembelian();
      case "Lunas":
        return const LunasPembelian();
      case "Void":
        return const VoidPembelian();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusList = tagihanCounts.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Tagihan Pembelian",
            style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Pembelianscreen()),
            );
          },
        ),
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
                : ListView.builder(
                    itemCount: statusList.length,
                    itemBuilder: (context, index) {
                      final label = statusList[index];
                      final count = tagihanCounts[label]!;
                      final color = statusColors[label] ?? Colors.grey;
                      final page = getTargetPage(label);

                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: color,
                              radius: 10,
                            ),
                            title: Text(label),
                            subtitle: Text("$count"),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
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
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Tambahkan aksi jika diperlukan
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
