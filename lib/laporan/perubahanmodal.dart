import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PerubahanModalPage extends StatefulWidget {
  @override
  _PerubahanModalPageState createState() => _PerubahanModalPageState();
}

class _PerubahanModalPageState extends State<PerubahanModalPage> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  // Mengambil data dari API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.23/hiyami/perubahanmodal.php'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      setState(() {
        data = responseData.map((item) => item as Map<String, dynamic>).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Fungsi untuk mengonversi nilai menjadi int
  int _toInt(dynamic value) {
    if (value is int) {
      return value; // Jika sudah int, tidak perlu diubah
    }
    if (value is String) {
      return int.tryParse(value) ?? 0; // Jika string, coba parse ke int, jika gagal kembalikan 0
    }
    return 0; // Nilai lainnya kembalikan 0
  }

  // Fungsi untuk menghitung total
  Map<String, int> hitungTotal() {
    Map<String, int> total = {
      "Awal": 0,
      "Debit": 0,
      "Kredit": 0,
      "Akhir": 0,
    };

    for (var item in data) {
      total["Awal"] = total["Awal"]! + _toInt(item["awal"]);
      total["Debit"] = total["Debit"]! + _toInt(item["debit"]);
      total["Kredit"] = total["Kredit"]! + _toInt(item["kredit"]);
      total["Akhir"] = total["Akhir"]! + _toInt(item["akhir"]);
    }

    return total;
  }

  // Fungsi untuk menghitung perubahan bersih (penjumlahan total Awal, Debit, Kredit, dan Akhir)
  int hitungPerubahanBersih() {
    int perubahanBersih = 0;

    for (var item in data) {
      // Menjumlahkan Awal, Debit, Kredit, dan Akhir untuk setiap item
      perubahanBersih += _toInt(item['awal']);
      perubahanBersih += _toInt(item['debit']);
      perubahanBersih += _toInt(item['kredit']);
      perubahanBersih += _toInt(item['akhir']);
    }

    return perubahanBersih;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final total = hitungTotal();
    final perubahanBersih = hitungPerubahanBersih(); // Mengambil perubahan bersih yang dihitung

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Perubahan Modal",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.grey[300],
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              child: Text(
                                item['section'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Awal"),
                                      Text("${item['awal']}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Debit"),
                                      Text("${item['debit']}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Kredit"),
                                      Text("${item['kredit']}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Akhir"),
                                      Text("${item['akhir']}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: 20),
                          ],
                        );
                      },
                    ),
                    // Menambahkan bagian Total
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.grey[300], // Sama seperti baris lainnya
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            child: Text(
                              "Total",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Awal"),
                                    Text("${total['Awal']}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Debit"),
                                    Text("${total['Debit']}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Kredit"),
                                    Text("${total['Kredit']}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Akhir"),
                                    Text("${total['Akhir']}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Memberikan jarak sebelum bagian Perubahan Bersih
                          SizedBox(height: 20), // Menambahkan jarak
                          // Menambahkan bagian Perubahan Bersih
                          Container(
                            width: double.infinity,
                            color: Colors.grey[300], // Sama dengan warna latar belakang Total
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            child: Text(
                              "Perubahan Bersih",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Perubahan Bersih"),
                                Text("$perubahanBersih"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'share',
            mini: true,
            onPressed: () {},
            child: Icon(Icons.share),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'download',
            onPressed: () {},
            child: Icon(Icons.download),
          ),
        ],
      ),
    );
  }
}
