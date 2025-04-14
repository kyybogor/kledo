import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Penjualan/penjualanscreen.dart';
import 'package:flutter_application_kledo/belumdibayar/belumdibayarscreen.dart';
import 'package:flutter_application_kledo/tagihan/dibayarsebagianscreen.dart';
import 'package:flutter_application_kledo/tagihan/tagihanscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Dashboardscreen(),
  ));
}

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.shopping_bag,
      'label': 'Penjualan',
      'color': Colors.redAccent
    },
    {
      'icon': Icons.shopping_cart,
      'label': 'Pembelian',
      'color': Colors.blueAccent
    },
    {'icon': Icons.money_off, 'label': 'Biaya', 'color': Colors.orangeAccent},
    {'icon': Icons.inventory, 'label': 'Produk', 'color': Colors.green},
    {'icon': Icons.bar_chart, 'label': 'Laporan', 'color': Colors.purple},
    {
      'icon': Icons.account_balance,
      'label': 'Kas & Bank',
      'color': Colors.teal
    },
    {'icon': Icons.domain, 'label': 'Aset Tetap', 'color': Colors.indigo},
    {'icon': Icons.contacts, 'label': 'Kontak', 'color': Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hayami',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),
      drawer: const KledoDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.blueAccent,
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi pengguna!',
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                  SizedBox(height: 4),
                  Text('Yuk mudahkan keuangan bisnis dengan Kledo',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  var item = menuItems[index];
                  return InkWell(
                    onTap: () {
                      if (item['label'] == 'Penjualan') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const Penjualanscreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Navigasi ke ${item['label']} belum tersedia')),
                        );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: item['color']?.withOpacity(0.2) ??
                              Colors.blue[50],
                          child: Icon(item['icon'],
                              color: item['color'] ?? Colors.blue),
                        ),
                        const SizedBox(height: 8),
                        Text(item['label'],
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.computer, size: 40),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Demo dan konsultasi Online',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Gratis'),
                          SizedBox(height: 4),
                          Text('Yuk Jadwalkan Sekarang'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text:
                              'Data yang tampil saat ini adalah data dummy. Setelah Anda siap, ',
                          children: [
                            TextSpan(
                              text: 'klik disini',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: ' untuk mengosongkan data.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kas & Bank',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildKasCard(
                      label: 'Kas',
                      amount: 'Rp 28.454.329',
                      color: Colors.pink[100]!,
                      abbreviation: 'K',
                    ),
                    const SizedBox(width: 12),
                    _buildKasCard(
                      label: 'Rekening Bank',
                      amount: 'Rp 34.848.928',
                      color: Colors.blue[100]!,
                      abbreviation: 'RB',
                    ),
                    const SizedBox(width: 12),
                    _buildKasCard(
                      label: 'Giro',
                      amount: 'Rp 12.342.000',
                      color: Colors.green[100]!,
                      abbreviation: 'G',
                    ),
                  ],
                ),
              ),
            ),

            // PERFORMA BISNIS SECTION
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Performa Bisnis',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text('Widget ${index + 1}',
                            style: const TextStyle(fontSize: 16)),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ubah Dashboard diklik')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Ubah Dashboard',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  static Widget _buildKasCard({
    required String label,
    required String amount,
    required Color color,
    required String abbreviation,
  }) {
    return Container(
      width: 180,
      height: 80,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                abbreviation,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(amount,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KledoDrawer extends StatefulWidget {
  const KledoDrawer({super.key});

  @override
  State<KledoDrawer> createState() => _KledoDrawerState();
}

class _KledoDrawerState extends State<KledoDrawer> {
  int? selectedIndex;
  String? selectedSubItem;

  final menuItems = const [
    {'icon': Icons.house, 'title': 'Beranda'},
    {
      'icon': Icons.shopping_bag,
      'title': 'Penjualan',
      'children': [
        'Overview Penjualan',
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
        'Overview Pembelian',
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
            ...menuItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = selectedIndex == index;

              if (item.containsKey('children')) {
                return Theme(
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
                      final isSubSelected =
                          selectedIndex == index && selectedSubItem == subItem;
                      return Container(
                        color:
                            isSubSelected ? Colors.white24 : Colors.transparent,
                        child: ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 72, right: 16),
                            title: Text(subItem,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: isSubSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal)),
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selectedSubItem = subItem;
                              });
                              Navigator.pop(context);

                              Widget? destination;

                              switch (subItem) {
                                case 'Overview Penjualan':
                                  destination = const Penjualanscreen(); // ganti sesuai nama halamanmu
                                  break;
                                case 'Tagihan':
                                  destination = const TagihanPage();
                                  break;
                                case 'Pengiriman Pembelian':
                                  //destination = const PengirimanPembelianPage();
                                  break;
                                case 'Pesanan Pembelian':
                                  //destination = const PesananPembelianPage();
                                  break;
                                case 'Penawaran Pembelian':
                                  //destination = const PenawaranPembelianPage();
                                  break;
                              }

                              if (destination != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => destination!),
                                );
                              }
                            }),
                      );
                    }).toList(),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      color: isSelected ? Colors.white24 : Colors.transparent,
                      child: ListTile(
                        leading:
                            Icon(item['icon'] as IconData, color: Colors.white),
                        title: Text(item['title'] as String,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedSubItem = null;
                          });
                          Navigator.pop(context);

                          Widget? destination;
                          if (item['title'] == 'Beranda') {
                            destination = const Dashboardscreen();
                          }
                          // Tambah halaman lainnya sesuai kebutuhan

                          if (destination != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => destination!),
                            );
                          }
                        },
                      ),
                    ),
                    if (['Inventori', 'Kontak', 'FAQ', 'Keluar']
                        .contains(item['title']))
                      const Divider(
                          color: Colors.white54, indent: 16, endIndent: 16),
                  ],
                );
              }
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
