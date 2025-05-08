import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
import 'package:flutter_application_kledo/belumdibayar/detailbelumdibayar.dart';
import 'package:flutter_application_kledo/kontak/detailkontak.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KontakScreen extends StatefulWidget {
  const KontakScreen({super.key});

  @override
  State<KontakScreen> createState() => _KontakScreenState();
}

class _KontakScreenState extends State<KontakScreen> {
  List<dynamic> allContacts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.9/connect/JSON/kontak.php"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        allContacts = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filtered = allContacts
        .where((item) =>
            item['nama'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList()
      ..sort((a, b) => a['nama'].compareTo(b['nama']));

    Map<String, List<dynamic>> grouped = {};
    for (var contact in filtered) {
      String huruf = contact['nama'][0].toUpperCase();
      grouped.putIfAbsent(huruf, () => []).add(contact);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kontak"),
      ),
      drawer: const KledoDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari nama...",
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: ListView(
              children: grouped.entries.expand((entry) {
                return [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.grey[300],
                    child: Text(entry.key,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ...entry.value.map((item) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.primaries[
                                  item['nama'].codeUnitAt(0) %
                                      Colors.primaries.length],
                              child: Text(
                                item['nama']
                                    .toString()
                                    .substring(0, 2)
                                    .toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(item['nama']),
                            subtitle: Text(item['instansi']),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailKontak(data: item),
                                ),
                              );
                            },
                          ),
                          Divider(height: 1),
                        ],
                      )),
                ];
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambah kontak nanti
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailKontak extends StatelessWidget {
  final dynamic data;
  const DetailKontak({super.key, required this.data});

  Future<List<dynamic>> fetchTransaksiTerakhir(int id) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.9/connect/JSON/transaksi_kontak.php?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mengambil transaksi');
    }
  }

  @override
  Widget build(BuildContext context) {
    String status = data['status'] ?? 'pegawai';
    int kontakId = int.tryParse(data['id'].toString()) ?? 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Kontak",
          style: TextStyle(
            color: Color(0xFF0D47A1), // Biru tua terang
          ),
        ),
        iconTheme:
            const IconThemeData(color: Color(0xFF0D47A1)), // Jika ada ikon back
      ),
      body: Column(
        children: [
          _buildStatusTabs(status),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildInfoCard(context),
                  ),
                  FutureBuilder<List<dynamic>>(
                    future: fetchTransaksiTerakhir(kontakId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text("Tidak ada transaksi."),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.grey[300],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Transaksi Terakhir",
                                        style: TextStyle(fontSize: 14)),
                                    Text(
                                      "Lihat Semua",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ...snapshot.data!.map((transaksi) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Detailbelumdibayar(
                                                  invoice: transaksi),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  transaksi['deskripsi'] ??
                                                      'Tanpa deskripsi',
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  transaksi['tanggal'] ?? '-',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            double.tryParse(transaksi['jumlah']
                                                        .toString())
                                                    ?.toStringAsFixed(2) ??
                                                transaksi['jumlah'].toString(),
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 14, color: Colors.grey),
                                          const SizedBox(width: 12),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // 👈 Untuk rata kiri
              children: [
                Text(
                  data['nama'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF005BBB),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 4),
                Text(
                  data['instansi'],
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16),
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade400,
                    child: Text(
                      data['nama'][0].toUpperCase(),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _infoRow(Icons.email, data['email']),
                _infoRow(Icons.phone, data['telepon']),
                _infoRow(Icons.location_on, data['alamat']),
              ],
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detailkontak(data: data),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Lihat Detail",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs(String activeStatus) {
    final List<Map<String, dynamic>> tabs = [
      {"label": "Vendor", "icon": Icons.shopping_cart, "value": "vendor"},
      {"label": "Pegawai", "icon": Icons.local_shipping, "value": "pegawai"},
      {
        "label": "Pelanggan",
        "icon": Icons.person_outline,
        "value": "pelanggan"
      },
      {
        "label": "Investor",
        "icon": Icons.handshake_outlined,
        "value": "investor"
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabs.map((tab) {
          bool isActive = tab['value'] == activeStatus;
          return Container(
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ]
                  : [],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Icon(
                  tab['icon'],
                  color: isActive ? Colors.blue : Colors.grey,
                ),
                const SizedBox(height: 4),
                Text(
                  tab['label'],
                  style: TextStyle(
                    color: isActive ? Colors.blue : Colors.grey,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _hutangCard(String label, String amount, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Text(amount,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
