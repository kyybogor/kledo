import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
import 'package:flutter_application_kledo/produk/produkdetail.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  bool _showChart = true;

  final List<Map<String, dynamic>> _produkList = [
    {
      'name': 'Chelsea Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.335',
      'code': 'CB1',
      'stok': 7230,
      'penjualan': 12,
      'nominalStok': '9.649.253',
      'nominalPenjualan': '5.740.748',
      'image': 'assets/chelsea_boots.jpg',
      'warehouse': {
        'Unassigned': 2086,
        'Gudang Utama': 2027,
        'Gudang Elektronik': 3117,
      },
      'transactions': [
        {'type': 'Penjualan', 'amount': '899.099', 'date': '15/04/2025'},
        {'type': 'Penjualan', 'amount': '998.000', 'date': '15/04/2025'},
        {'type': 'Pembelian', 'amount': '598.000', 'date': '14/04/2025'},
      ],
      'movements': [
        {'type': 'Penjualan', 'qty': -2},
        {'type': 'Pembelian', 'qty': 2},
        {'type': 'Penjualan', 'qty': -3},
      ],
    },
    {
      'name': 'iMac Computer',
      'hpp': '0',
      'hargaJual': '12.000.000',
      'hppValue': '0',
      'code': 'COM1',
      'stok': 0,
      'penjualan': 1,
      'nominalStok': '0',
      'nominalPenjualan': '12.000.000',
      'image': 'assets/imac.jpg',
      'warehouse': {
        'Gudang Utama': 0,
      },
      'transactions': [],
      'movements': [],
    },
    {
      'name': 'Kneel High Boots',
      'hpp': '299.000',
      'hargaJual': '499.000',
      'hppValue': '1.327',
      'code': 'KH1',
      'stok': 7213,
      'penjualan': 14,
      'nominalStok': '9.573.701',
      'nominalPenjualan': '14.871.099',
      'image': 'assets/kneel_boots.jpg',
      'warehouse': {
        'Unassigned': 2074,
        'Gudang Utama': 2030,
        'Gudang Elektronik': 3109,
      },
      'transactions': [
        {'type': 'Penjualan', 'amount': '899.099', 'date': '15/04/2025'},
        {'type': 'Penjualan', 'amount': '998.000', 'date': '15/04/2025'},
        {'type': 'Pembelian', 'amount': '598.000', 'date': '14/04/2025'},
      ],
      'movements': [
        {'type': 'Penjualan', 'qty': -2},
        {'type': 'Pembelian', 'qty': 2},
        {'type': 'Penjualan', 'qty': -3},
      ],
    },
    {
      'name': 'Moslem Brown Blue Dress',
      'hpp': '49.000',
      'hargaJual': '199.000',
      'hppValue': '0',
      'code': 'DR2',
      'stok': 122,
      'penjualan': 7,
      'nominalStok': '2.000.000',
      'nominalPenjualan': '1.393.000',
      'image': 'assets/brown_blue_dress.jpg',
      'warehouse': {
        'Gudang Elektronik': 122,
      },
      'transactions': [
        {'type': 'Penjualan', 'amount': '199.000', 'date': '12/04/2025'},
      ],
      'movements': [
        {'type': 'Penjualan', 'qty': -1},
      ],
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
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
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
          ..._produkList.map((produk) {
            return _buildProductItem(produk);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> produk) {
    return ListTile(
      title: Text(produk['name'] ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${produk['hpp']} → ${produk['hargaJual']}'),
          Text('${produk['hppValue']} (HPP)', style: const TextStyle(fontSize: 12)),
          Text('${produk['code']}', style: const TextStyle(fontSize: 12)),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: produk),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard(String title, String count, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.65,
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
                Text(
                  count,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
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
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
