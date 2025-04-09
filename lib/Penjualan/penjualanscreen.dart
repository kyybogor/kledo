import 'package:flutter/material.dart';


class Penjualanscreen extends StatefulWidget {
  const Penjualanscreen({super.key});

  @override
  State<Penjualanscreen> createState() => _PenjualanscreenState();
}

class _PenjualanscreenState extends State<Penjualanscreen> {
  int _selectedIndex = 0;
  final List<Color> chartColors = [
    Colors.green,
    Colors.lightBlue,
    Colors.purple,
    Colors.grey,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan'),
        backgroundColor: const Color(0xFF1565C0), // Warna biru gradasi
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMenuGrid(),
            _buildDummyWarning(),
            _buildToggleTab(),
            _buildSalesInfo(),
            _buildSalesPerformanceChart(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Penjualan"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan"),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _MenuIcon(icon: Icons.receipt_long, label: 'Tagihan', color: Colors.orange),
          _MenuIcon(icon: Icons.local_shipping, label: 'Pengiriman', color: Colors.blue),
          _MenuIcon(icon: Icons.schedule, label: 'Pemesanan', color: Colors.green),
          _MenuIcon(icon: Icons.description, label: 'Penawaran', color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildDummyWarning() {
    return Container(
      color: Colors.yellow[100],
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Text.rich(
        TextSpan(
          text: 'Data yang tampil saat ini adalah data dummy. Setelah Anda siap, ',
          children: [
            TextSpan(
              text: 'klik disini',
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
            TextSpan(text: ' untuk mengosongkan data.'),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Bulan"),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Tahun"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: ListTile(
          title: const Text("Penjualan"),
          subtitle: const Text("Rp 28,471,460"),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("11", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Bulan Lalu"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalesPerformanceChart() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Penjualan Per Produk Bulan Ini",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 12,
            children: [
              LegendItem(color: Colors.green, text: "Moslem Pink Dress"),
              LegendItem(color: Colors.lightBlue, text: "Chelsea Boots"),
              LegendItem(color: Colors.purple, text: "Moslem Purple Dress"),
              LegendItem(color: Colors.grey, text: "Moslem Grey Shirt"),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MenuIcon({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
