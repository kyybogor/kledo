import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(product['name']!, style: const TextStyle(fontSize: 20)),
            Text(product['code'], style: const TextStyle(fontSize: 12)),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.more_vert),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stok & Penjualan Info
// Stok & Penjualan Info (scrollable)
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      _buildInfoCard('Stok di tangan', '7.230', Colors.pink),
      _buildInfoCard('Penjualan', '12', Colors.orange),
      _buildInfoCard('Habis', '0', Colors.blue),
    ],
  ),
),
            const SizedBox(height: 16),

            // Detail Produk
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/kneel_boots.jpg'), // Ganti asset sesuai kebutuhan
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [const Icon(Icons.inventory_2), const SizedBox(width: 8), Text(product['name']!)]),
                      const SizedBox(height: 4),
                      Row(children: [const Icon(Icons.category), const SizedBox(width: 8), const Text('Kategori: Shoes')]),
                      const SizedBox(height: 4),
                      Row(children: [const Icon(Icons.straighten), const SizedBox(width: 8), const Text('Satuan: Pcs')]),
                      const SizedBox(height: 4),
                      Row(children: [const Icon(Icons.shopping_bag), const SizedBox(width: 8), Text('Harga Beli: ${product['hpp']}')]),
                      const SizedBox(height: 4),
                      Row(children: [const Icon(Icons.sell), const SizedBox(width: 8), Text('Harga Jual: ${product['hargaJual']}')]),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Grafik
            Row(
              children: [
                Expanded(child: _buildChartPlaceholder('Penjualan vs Pembelian')),
                const SizedBox(width: 12),
                Expanded(child: _buildChartPlaceholder('Pergerakan')),
              ],
            ),
            const SizedBox(height: 24),

            // Unit dan Gudang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Unit', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Tambah konversi satuan', style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Satuan Dasar: Pcs'),
            const SizedBox(height: 16),
            const Text('Gudang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildWarehouseRow('Unassigned', '2.086'),
            _buildWarehouseRow('Gudang Utama', '2.027'),
            _buildWarehouseRow('Gudang Elektronik', '3.117'),
            const Divider(),
            _buildWarehouseRow('Total', '7.230', isBold: true),
            const SizedBox(height: 24),

            // Transaksi Terakhir
            const Text('Transaksi Terakhir', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTransactionRow('Tagihan Penjualan', '899.099', '15/04/2025'),
            _buildTransactionRow('Tagihan Penjualan', '998.000', '15/04/2025'),
            _buildTransactionRow('Tagihan Pembelian', '598.000', '14/04/2025'),
            const SizedBox(height: 24),

            // Pergerakan Stok
            const Text('Pergerakan Stok', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildStockMovement('Tagihan Penjualan', '-2', Colors.red),
            _buildStockMovement('Tagihan Pembelian', '+2', Colors.green),
            _buildStockMovement('Tagihan Penjualan', '-3', Colors.red),
          ],
        ),
      ),
    );
  }

Widget _buildInfoCard(String title, String value, Color color) {
  return Container(
    width: 200, // Atur lebar sesuai kebutuhan
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    ),
  );
}


  Widget _buildChartPlaceholder(String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(12),
        child: Center(child: Text(title)),
      ),
    );
  }

  Widget _buildWarehouseRow(String name, String qty, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text(qty, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(String title, String amount, String date) {
    return ListTile(
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStockMovement(String title, String qty, Color color) {
    return ListTile(
      title: Text(title),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(qty, style: TextStyle(color: color)),
      ),
    );
  }
}
