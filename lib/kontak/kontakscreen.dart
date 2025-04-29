import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
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
        await http.get(Uri.parse("http://192.168.1.26/connect/JSON/kontak.php"));
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

  @override
  Widget build(BuildContext context) {
    String status = data['status'] ?? 'pegawai'; // default jika tidak ada

    return Scaffold(
      appBar: AppBar(title: const Text("Kontak")),
      body: Column(
        children: [
          _buildStatusTabs(status),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(data['nama'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(data['instansi'],
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 16),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade400,
                            child: Text(data['nama'][0].toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white)),
                          ),
                          const SizedBox(height: 16),
                          _infoRow(Icons.email, data['email']),
                          _infoRow(Icons.phone, data['telepon']),
                          _infoRow(Icons.location_on, data['alamat']),
                          const Divider(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text("Lihat Detail")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child:
                              _hutangCard("Anda Hutang", "0", Colors.orange)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _hutangCard(
                              "Mereka Hutang", "0", Colors.redAccent)),
                    ],
                  ),
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
