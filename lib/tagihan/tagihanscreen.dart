import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Penjualan/penjualanscreen.dart';
import 'package:flutter_application_kledo/lunas/lunas.dart';
import 'package:flutter_application_kledo/void/void.dart';
import 'package:http/http.dart' as http;

// Import halaman-halaman
import 'package:flutter_application_kledo/belumdibayar/belumdibayarscreen.dart';
import 'package:flutter_application_kledo/dibayarsebagian/dibayarsebagian.dart';

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
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

  @override
  void initState() {
    super.initState();
    fetchTagihanCounts();
  }

  Future<void> fetchTagihanCounts() async {
    try {
      final response = await http.get(Uri.parse('https://gmp-system.com/api-hayami/daftar_tagihan.php?sts=1'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        Map<String, int> newCounts = {
          for (var key in tagihanCounts.keys) key: 0,
        };

        for (var item in data) {
          String status = item['status'] ?? "Belum Dibayar"; // Ganti sesuai field API
          if (newCounts.containsKey(status)) {
            newCounts[status] = newCounts[status]! + 1;
          }
        }

        setState(() {
          tagihanCounts = newCounts;
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

  // Fungsi buka halaman sesuai status
  Widget? getTargetPage(String label) {
    switch (label) {
      case "Belum Dibayar":
        return const BelumDibayar();
      case "Dibayar Sebagian":
        return const Dibayarsebagian();
      case "Lunas":
        return const Lunas();
      case "Void":
        return const Void();
      // Tambahkan halaman lainnya sesuai kebutuhan
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusList = tagihanCounts.keys.toList();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Penjualanscreen()),
        );
        return false; // cegah pop default
      },
      child: Scaffold(
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
                              trailing: Text("$count"),
                              onTap: page != null
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => page),
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
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
