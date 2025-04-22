import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  bool _showChart = true;

  // Contoh data produk
  final List<Map<String, String>> _produkList = [
    {
      'name': 'Chelsea Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.335',
      'code': 'CB1',
    },
    {
      'name': 'iMac Computer',
      'hpp': '0',
      'hargaJual': '12.000.000',
      'hppValue': '0',
      'code': 'COM1',
    },
    {
      'name': 'Kneel High Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.327',
      'code': 'KH1',
    },
    {
      'name': 'Moslem Brown Blue Dress',
      'hpp': '49.000',
      'hargaJual': '199.000',
      'hppValue': '0',
      'code': 'DR2',
    },
    {
      'name': 'PC Computer',
      'hpp': '0',
      'hargaJual': '21.000.000',
      'hppValue': '0',
      'code': 'COM2',
    },
    {
      'name': 'Chelsea Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.335',
      'code': 'CB1',
    },
    {
      'name': 'iMac Computer',
      'hpp': '0',
      'hargaJual': '12.000.000',
      'hppValue': '0',
      'code': 'COM1',
    },
    {
      'name': 'Kneel High Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.327',
      'code': 'KH1',
    },
    {
      'name': 'Moslem Brown Blue Dress',
      'hpp': '49.000',
      'hargaJual': '199.000',
      'hppValue': '0',
      'code': 'DR2',
    },
    {
      'name': 'PC Computer',
      'hpp': '0',
      'hargaJual': '21.000.000',
      'hppValue': '0',
      'code': 'COM2',
    },
    {
      'name': 'Chelsea Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.335',
      'code': 'CB1',
    },
    {
      'name': 'iMac Computer',
      'hpp': '0',
      'hargaJual': '12.000.000',
      'hppValue': '0',
      'code': 'COM1',
    },
    {
      'name': 'Kneel High Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.327',
      'code': 'KH1',
    },
    {
      'name': 'Moslem Brown Blue Dress',
      'hpp': '49.000',
      'hargaJual': '199.000',
      'hppValue': '0',
      'code': 'DR2',
    },
    {
      'name': 'PC Computer',
      'hpp': '0',
      'hargaJual': '21.000.000',
      'hppValue': '0',
      'code': 'COM2',
    },
    {
      'name': 'Chelsea Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.335',
      'code': 'CB1',
    },
    {
      'name': 'iMac Computer',
      'hpp': '0',
      'hargaJual': '12.000.000',
      'hppValue': '0',
      'code': 'COM1',
    },
    {
      'name': 'Kneel High Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.327',
      'code': 'KH1',
    },
    {
      'name': 'Moslem Brown Blue Dress',
      'hpp': '49.000',
      'hargaJual': '199.000',
      'hppValue': '0',
      'code': 'DR2',
    },
    {
      'name': 'PC Computer',
      'hpp': '0',
      'hargaJual': '21.000.000',
      'hppValue': '0',
      'code': 'COM2',
    },
    {
      'name': 'Chelsea Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.335',
      'code': 'CB1',
    },
    {
      'name': 'iMac Computer',
      'hpp': '0',
      'hargaJual': '12.000.000',
      'hppValue': '0',
      'code': 'COM1',
    },
    {
      'name': 'Kneel High Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.327',
      'code': 'KH1',
    },
    {
      'name': 'Moslem Brown Blue Dress',
      'hpp': '49.000',
      'hargaJual': '199.000',
      'hppValue': '0',
      'code': 'DR2',
    },
    {
      'name': 'PC Computer',
      'hpp': '0',
      'hargaJual': '21.000.000',
      'hppValue': '0',
      'code': 'COM2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const KledoDrawer(),
      appBar: AppBar(
        title: const Text('Produk'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambah Produk
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Cari',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 12),

          // Status Cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildStatusCard('Produk Stok Tersedia', '2', Colors.green),
                _buildStatusCard('Produk Stok Hampir Habis', '0', Colors.orange),
                _buildStatusCard('Produk Stok Habis', '0', Colors.red),
                _buildStatusCard('Produk Nonaktif', '0', Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Toggle chart
          InkWell(
            onTap: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showChart ? 'Sembunyikan' : 'Lihat Selengkapnya',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                Icon(_showChart ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (_showChart)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChartPlaceholder('Pergerakan Stok', screenWidth),
                  _buildChartPlaceholder('Jenis Produk', screenWidth),
                ],
              ),
            ),
          const SizedBox(height: 16),

          // List Produk
          ..._produkList.map((produk) => _buildProductItem(
                produk['name']!,
                produk['hpp']!,
                produk['hargaJual']!,
                produk['hppValue']!,
                produk['code']!,
              )),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, String count, Color color) {
    return Container(
      width: 300,
      height: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Text(count,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder(String title, double width) {
    return Container(
      width: width - 90,
      height: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildProductItem(
    String name,
    String hpp,
    String hargaJual,
    String hppValue,
    String code,
  ) {
    return ListTile(
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$hpp → $hargaJual'),
          Text('$hppValue (HPP)', style: const TextStyle(fontSize: 12)),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('0'),
      ),
      onTap: () {
        // Navigasi ke detail produk jika diperlukan
      },
    );
  }
}
