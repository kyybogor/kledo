import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_kledo/belumdibayar/belumdibayarscreen.dart';

// Drawer Kledo
class KledoDrawer extends StatelessWidget {
  const KledoDrawer({super.key});

  final menuItems = const [
    {'icon': Icons.house, 'title': 'Beranda'},
    {
      'icon': Icons.shopping_bag,
      'title': 'Penjualan',
      'children': [
        'Overview',
        'Tagihan',
        'Pengiriman',
        'Pemesanan',
        'Penawaran'
      ]
    },
    {
      'icon': Icons.shopping_cart,
      'title': 'Pembelian',
      'children': [
        'Overview',
        'Tagihan Pembelian',
        'Pengiriman Pembelian',
        'Pesanan Pembelian',
        'Penawaran Pembelian'
      ]
    },
    {'icon': Icons.money_off, 'title': 'Biaya'},
    {'icon': Icons.inventory_2, 'title': 'Produk'},
    {'icon': Icons.local_shipping, 'title': 'Inventori'},
    {'icon': Icons.bar_chart, 'title': 'Laporan'},
    {'icon': Icons.account_balance, 'title': 'Kas & Bank'},
    {'icon': Icons.person, 'title': 'Akun'},
    {'icon': Icons.domain, 'title': 'Aset Tetap'},
    {'icon': Icons.contacts, 'title': 'Kontak'},
    {'icon': Icons.settings, 'title': 'Pengaturan'},
    {'icon': Icons.help_outline, 'title': 'FAQ'},
    {'icon': Icons.exit_to_app, 'title': 'Keluar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A75CF), Color(0xFF007BFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Hayami',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Zahlfan Wiranto',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text('prt ayam',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.yellowAccent,
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(Icons.info, size: 16, color: Colors.black)),
                    TextSpan(
                      text:
                          '  Data yang tampil saat ini adalah data dummy. Setelah Anda siap, ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'klik disini',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: ' untuk mengosongkan data.',
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
            ...menuItems.asMap().entries.map((entry) {
              final item = entry.value;

              Widget listTile;
              if (item.containsKey('children')) {
                listTile = Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    leading:
                        Icon(item['icon'] as IconData, color: Colors.white),
                    title: Text(item['title'] as String,
                        style: const TextStyle(color: Colors.white)),
                    children: (item['children'] as List<String>).map((subItem) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 72, right: 16),
                        title: Text(subItem,
                            style: const TextStyle(color: Colors.white)),
                        onTap: () => Navigator.pop(context),
                      );
                    }).toList(),
                  ),
                );
              } else {
                listTile = ListTile(
                  leading: Icon(item['icon'] as IconData, color: Colors.white),
                  title: Text(item['title'] as String,
                      style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context),
                );
              }

              bool needsDivider = ['Inventori', 'Kontak', 'FAQ', 'Keluar']
                  .contains(item['title']);

              return Column(
                children: [
                  listTile,
                  if (needsDivider)
                    const Divider(
                        color: Colors.white54, indent: 16, endIndent: 16),
                ],
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // WhatsApp action
                },
                icon: const FaIcon(FontAwesomeIcons.whatsapp),
                label: const Text('Halo, ada yang bisa saya bantu?'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Tagihan
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TagihanPage(),
  ));
}

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  final List<Map<String, dynamic>> tagihanList = const [
    {"label": "Belum Dibayar", "count": 26, "color": Colors.pink},
    {"label": "Dibayar Sebagian", "count": 1, "color": Colors.amber},
    {"label": "Lunas", "count": 19, "color": Colors.green},
    {"label": "Void", "count": 0, "color": Colors.grey},
    {"label": "Jatuh Tempo", "count": 0, "color": Colors.black},
    {"label": "Retur", "count": 0, "color": Colors.orange},
    {"label": "Transaksi Berulang", "count": 0, "color": Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const KledoDrawer(),
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
            child: ListView.separated(
              itemCount: tagihanList.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = tagihanList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item['color'],
                    radius: 10,
                  ),
                  title: Text(item['label']),
                  trailing: Text("${item['count']}"),
                  onTap: item['label'] == "Belum Dibayar"
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BelumDibayarPage(),
                            ),
                          );
                        }
                      : null,
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
    );
  }
}
