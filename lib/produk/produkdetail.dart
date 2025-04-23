import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
import 'package:flutter_application_kledo/produk/unit.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp());
}

// Fungsi untuk format Rupiah
String formatRupiah(dynamic amount) {
  try {
    final value = double.tryParse(amount.toString()) ?? 0;
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
        .format(value);
  } catch (e) {
    return 'Rp 0';
  }
}

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map<String, dynamic>? gudangData;
  bool isLoadingGudang = true;

  @override
  void initState() {
    super.initState();
    fetchGudangData();
  }

  Future<void> fetchGudangData() async {
    final produkId = widget.product['id'];
    final url = Uri.parse('http://192.168.1.15/hiyami/gudang.php?produk_id=$produkId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('error')) throw Exception(data['error']);
        setState(() {
          gudangData = data;
          isLoadingGudang = false;
        });
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      setState(() => isLoadingGudang = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data gudang: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

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
        actions: [_buildPopupMenu(context)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildInfoCard('Stok di tangan', product['stok'].toString(), Colors.pink),
                  _buildInfoCard('Penjualan', product['penjualan'].toString(), Colors.orange),
                  _buildInfoCard('Hpp', product['hpp_value'].toString(), Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildProductDetails(product),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChartPlaceholder('Penjualan vs Pembelian'),
                  const SizedBox(width: 12),
                  _buildChartPlaceholder('Pergerakan'),
                  const SizedBox(width: 12),
                  _buildChartPlaceholder('Grafik Lainnya'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _sectionHeaderWithAction(context, 'Unit', 'Tambah konversi satuan', actionColor: Colors.blue),
            const SizedBox(height: 8),
            const Text('Satuan Dasar: Pcs'),
            const SizedBox(height: 16),
            _sectionHeader('Gudang'),
            const SizedBox(height: 8),
            if (isLoadingGudang)
              const Center(child: CircularProgressIndicator())
            else if (gudangData != null) ...[
              _buildWarehouseRow('Unassigned', gudangData!['unassigned'].toString()),
              _buildWarehouseRow('Gudang Utama', gudangData!['gudang_utama'].toString()),
              _buildWarehouseRow('Gudang Elektronik', gudangData!['gudang_elektronik'].toString()),
              const Divider(),
              _buildWarehouseRow('Total', gudangData!['total'].toString(), isBold: true),
            ] else
              const Text('Data gudang tidak ditemukan.'),
            const SizedBox(height: 24),
            _sectionHeaderWithAction(context, 'Transaksi Terkini', 'Lihat Semua', actionColor: Colors.blue),
            _buildTransactionRow('Tagihan Penjualan', '899.099', '15/04/2025'),
            _buildTransactionRow('Tagihan Penjualan', '998.000', '15/04/2025'),
            _buildTransactionRow('Tagihan Pembelian', '598.000', '14/04/2025'),
            const SizedBox(height: 24),
            _sectionHeaderWithAction(context, 'Pergerakan Stok', 'Lihat Semua', actionColor: Colors.blue),
            _buildStockMovement('Tagihan Penjualan', '-2', Colors.red),
            _buildStockMovement('Tagihan Pembelian', '+2', Colors.green),
            _buildStockMovement('Tagihan Penjualan', '-3', Colors.red),
            const SizedBox(height: 24),
            _sectionHeaderWithAction(context, 'Transfer Gudang', 'Lihat Semua', actionColor: Colors.blue),
            _buildTransferList(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (value) {
        if (value == 'audit') {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Lihat Audit'),
              content: const Text('Menampilkan log audit untuk produk ini.'),
              actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup'))],
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fitur belum tersedia.')),
          );
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'audit', child: Row(children: [Icon(Icons.history), SizedBox(width: 8), Text('Lihat Audit')])),
        PopupMenuItem(value: 'ubah', child: Row(children: [Icon(Icons.edit), SizedBox(width: 8), Text('Ubah')])),
        PopupMenuItem(value: 'duplikat', child: Row(children: [Icon(Icons.copy), SizedBox(width: 8), Text('Duplikat')])),
        PopupMenuItem(value: 'konversi', child: Row(children: [Icon(Icons.swap_horiz), SizedBox(width: 8), Text('Konversi Satuan')])),
        PopupMenuItem(value: 'arsipkan', child: Row(children: [Icon(Icons.archive), SizedBox(width: 8), Text('Arsipkan')])),
      ],
    );
  }

  Widget _buildProductDetails(Map<String, dynamic> product) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/kneel_boots.jpg'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [const Icon(Icons.inventory_2), const SizedBox(width: 8), Text(product['name'])]),
              const SizedBox(height: 4),
              const Row(children: [Icon(Icons.category), SizedBox(width: 8), Text('Kategori: Shoes')]),
              const SizedBox(height: 4),
              const Row(children: [Icon(Icons.straighten), SizedBox(width: 8), Text('Satuan: Pcs')]),
              const SizedBox(height: 4),
              Row(children: [const Icon(Icons.shopping_bag), const SizedBox(width: 8), Text('Harga Beli: ${formatRupiah(product['hpp'])}')]),
              const SizedBox(height: 4),
              Row(children: [const Icon(Icons.sell), const SizedBox(width: 8), Text('Harga Jual: ${formatRupiah(product['harga_jual'])}')]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder(String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(width: 250, height: 150, padding: const EdgeInsets.all(12), child: Center(child: Text(title))),
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
        decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
        child: Text(qty, style: TextStyle(color: color)),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _sectionHeaderWithAction(BuildContext context, String title, String actionText, {Color actionColor = Colors.black}) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          InkWell(
            onTap: () {
              if (title == 'Unit') {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const KonversiSatuanPage()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboardscreen()));
              }
            },
            child: Text(actionText, style: TextStyle(color: actionColor, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferList() {
    final items = ['WT/00004', 'WT/00003', 'WT/00002', 'WT/00001'];
    return Column(
      children: items.map((e) {
        return ListTile(
          title: Text(e),
          subtitle: Text('0${items.indexOf(e) + 6}/03/2025'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      }).toList(),
    );
  }
}
