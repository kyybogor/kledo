import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
import 'package:flutter_application_kledo/pemesanan/pemesananscreen.dart';
import 'package:flutter_application_kledo/penawaran/penawaranscreen.dart';
import 'package:flutter_application_kledo/tagihan/tagihanscreen.dart';
import 'package:flutter_application_kledo/pengiriman/pengirimanscreen.dart';

class Penjualanscreen extends StatefulWidget {
  const Penjualanscreen({super.key});

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
  State<Penjualanscreen> createState() => _PenjualanscreenState();
}

class _PenjualanscreenState extends State<Penjualanscreen> {
  List<bool> isSelected = [true, false];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const KledoDrawer(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildAppBar(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 12),
                _buildIconMenu(),
                const SizedBox(height: 16),
                _buildToggleWaktu(),
                const SizedBox(height: 16),
                _buildStatCards(),
                const SizedBox(height: 25),
                _buildPieChartCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildAppBar() {
  return ClipPath(
    clipper: BottomWaveClipper(),
    child: Container(
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(
          children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 28), 
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            iconSize: 26,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 28),
      child: const Text(
        'Penjualan',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const SizedBox(width: 48), // Ini biar kanan dan kiri seimbang
  ],
),

          ],
        ),
      ),
    ),
  );
}


  Widget _buildIconMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MenuIcon(
            icon: Icons.receipt_long,
            color: Colors.redAccent,
            label: 'Tagihan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TagihanPage(),
                ),
              );
            },
          ),
          _MenuIcon(
            icon: Icons.local_shipping,
            color: Colors.lightBlue,
            label: 'Pengiriman',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PengirimanPage(),
                ),
              );
            },
          ),
          _MenuIcon(
            icon: Icons.access_time,
            color: Colors.lightGreen,
            label: 'Pemesanan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PemesananPage(),
                ),
              );
            },
          ),
          _MenuIcon(
            icon: Icons.note_add,
            color: Colors.orangeAccent,
            label: 'Penawaran',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PenawaranPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleWaktu() {
    List<bool> waktuSelected = [true, false];

    return StatefulBuilder(
      builder: (context, setState) {
        return Align(
          alignment: Alignment.centerLeft,
          child: ToggleButtons(
            isSelected: waktuSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < waktuSelected.length; i++) {
                  waktuSelected[i] = i == index;
                }
              });
            },
            borderRadius: BorderRadius.circular(8),
            selectedBorderColor: Colors.blue,
            selectedColor: Colors.blue,
            fillColor: Colors.blue.withOpacity(0.1),
            color: Colors.black54,
            constraints: const BoxConstraints(minHeight: 30, minWidth: 85),
            children: const [
              Text('Bulan'),
              Text('Tahun'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tagihan Penjualan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 200,
                child: const _StatCard(
                  title: 'Judul',
                  amount: 'Rp 0',
                  growth: '+0%',
                  count: '0',
                  subtitle: 'Bulan Lalu',
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPieChartCard() {
    int totalPages = 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performa Penjualan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: PageController(viewportFraction: 1),
                  itemCount: totalPages,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Penjualan Per Produk Bulan Ini',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Icon(Icons.filter_alt_outlined),
                              ],
                            ),
                            const SizedBox(height: 12),
                            if (index == 0) ...[
                              _buildToggleProdukKategori(),
                              const SizedBox(height: 12),
                            ],
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                    child: Text('Chart Placeholder')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.blueAccent
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleProdukKategori() {
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      borderRadius: BorderRadius.circular(8),
      selectedBorderColor: Colors.blue,
      selectedColor: Colors.blue,
      fillColor: Colors.blue.withOpacity(0.1),
      color: Colors.black54,
      constraints: const BoxConstraints(minHeight: 23, minWidth: 70),
      children: const [
        Text('Produk'),
        Text('Kategori'),
      ],
    );
  }
}

class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback? onTap;

  const _MenuIcon({
    required this.icon,
    required this.color,
    required this.label,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title, amount, growth, count, subtitle;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.growth,
    required this.count,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(amount,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(growth,
              style: const TextStyle(color: Colors.green, fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle, style: const TextStyle(fontSize: 12)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(6)),
                child: Text(count, style: const TextStyle(fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
