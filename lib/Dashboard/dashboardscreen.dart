import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.shopping_bag, 'label': 'Penjualan'},
    {'icon': Icons.shopping_cart, 'label': 'Pembelian'},
    {'icon': Icons.money_off, 'label': 'Biaya'},
    {'icon': Icons.inventory, 'label': 'Produk'},
    {'icon': Icons.bar_chart, 'label': 'Laporan'},
    {'icon': Icons.account_balance, 'label': 'Kas & Bank'},
    {'icon': Icons.domain, 'label': 'Aset Tetap'},
    {'icon': Icons.contacts, 'label': 'Kontak'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
  backgroundColor: Colors.blueAccent,
  elevation: 0,
  centerTitle: true, // ini yang bikin teks di tengah
  title: const Text('contoh toko'),
  actions: const [
    Padding(
      padding: EdgeInsets.only(right: 12),
      child: Icon(Icons.notifications_none),
    )
  ],
),

      drawer: KledoDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              color: Colors.blueAccent,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hi pengguna!',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Yuk mudahkan keuangan bisnis dengan Kledo',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Menu Grid
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
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue[50],
                        child: Icon(item['icon'], color: Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['label'],
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                },
              ),
            ),

            // Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.computer, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Demo dan konsultasi Online',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Gratis'),
                          SizedBox(height: 4),
                          Text('Yuk Jadwalkan Sekarang'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Dummy warning
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

            // Judul "Kas & Bank"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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

            // Kas & Bank Cards (Scroll Horizontal)
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildKasCard({
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
                Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KledoDrawer extends StatelessWidget {
  final menuItems = [
    {'icon': Icons.house, 'title': 'Beranda'},
    {
      'icon': Icons.shopping_bag,
      'title': 'Penjualan',
      'children': ['Overview', 'Tagihan', 'Pengiriman', 'Pemesanan', 'Penawaran']
    },
    {
      'icon': Icons.shopping_cart,
      'title': 'Pembelian',
      'children': [
        'Overview',
        'Tagihan Pembelian',
        'Pengiriman Pembelian',
        'Pesanan Pembelian',
        'Penawaran Pembelian',
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
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kledo',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Zahlfan Wiranto',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('prt ayam',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            Container(
              color: Colors.yellowAccent,
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.info, size: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: '  Data yang tampil saat ini adalah data dummy. Setelah Anda siap, ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'klik disini',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: ' untuk mengosongkan data.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            ...menuItems.map((item) {
              if (item.containsKey('children')) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    unselectedWidgetColor: Colors.white70,
                  ),
                  child: ExpansionTile(
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    leading: Icon(item['icon'] as IconData, color: Colors.white),
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
                return ListTile(
                  leading: Icon(item['icon'] as IconData, color: Colors.white),
                  title: Text(item['title'] as String,
                      style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context),
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
