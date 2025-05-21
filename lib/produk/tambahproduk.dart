import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();  // Menambahkan controller untuk 'code'

  String? _selectedKategori; // Variabel untuk menyimpan kategori yang dipilih
  List<String> _kategoriList = []; // List untuk kategori

  // Ambil data kategori dari API
  Future<void> _fetchKategori() async {
    final url = Uri.parse('http://192.168.1.8/hiyami/kategori.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> kategoriData = json.decode(response.body);
      setState(() {
        _kategoriList = kategoriData.map((kategori) => kategori['nama_kategori'] as String).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat kategori')),
      );
    }
  }

  // Kirim data produk ke API
  Future<void> _submitProduk() async {
    if (_formKey.currentState!.validate() && _selectedKategori != null) {
      final url = Uri.parse('http://192.168.1.8/hiyami/tambah_produk.php');
      final response = await http.post(
        url,
        body: {
          'produk_name': _namaController.text,
          'harga_jual': _hargaController.text,
          'stok': _stokController.text,
          'kategori': _selectedKategori!,  // Kirim kategori yang dipilih
          'code': _codeController.text,
        },
      );

      if (response.statusCode == 200) {
        final result = response.body;
        if (result.contains('success')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produk berhasil ditambahkan')),
          );
          Navigator.pop(context, true); // Return true untuk refresh halaman
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal menambahkan produk')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terjadi kesalahan jaringan')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchKategori(); // Panggil fungsi untuk ambil data kategori
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama Produk
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue), // Border untuk rounded corner
                ),
                child: TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Produk',
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    border: InputBorder.none,
                  ),
                  validator: (value) => value!.isEmpty ? 'Masukkan nama produk' : null,
                ),
              ),
              const SizedBox(height: 16),
              // Harga Jual
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue), // Border untuk rounded corner
                ),
                child: TextFormField(
                  controller: _hargaController,
                  decoration: const InputDecoration(
                    labelText: 'Harga Jual',
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Masukkan harga jual' : null,
                ),
              ),
              const SizedBox(height: 16),
              // Stok
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue), // Border untuk rounded corner
                ),
                child: TextFormField(
                  controller: _stokController,
                  decoration: const InputDecoration(
                    labelText: 'Stok',
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Masukkan stok' : null,
                ),
              ),
              const SizedBox(height: 16),
              // Dropdown Kategori
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue), // Border untuk rounded corner
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedKategori,
                  onChanged: (value) {
                    setState(() {
                      _selectedKategori = value;
                    });
                  },
                  items: _kategoriList.map((kategori) {
                    return DropdownMenuItem<String>(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    border: InputBorder.none,
                  ),
                  validator: (value) => value == null ? 'Pilih kategori' : null,
                ),
              ),
              const SizedBox(height: 16),
              // Code Produk
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue), // Border untuk rounded corner
                ),
                child: TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Code Produk',
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    border: InputBorder.none,
                  ),
                  validator: (value) => value!.isEmpty ? 'Masukkan kode produk' : null,
                ),
              ),
              const SizedBox(height: 24),
              // Tombol Simpan
              ClipRRect(
                borderRadius: BorderRadius.circular(30), // Sudut melengkung
                child: ElevatedButton(
                  onPressed: _submitProduk,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    backgroundColor: Colors.blue, // Ganti 'primary' dengan 'backgroundColor'
                  ),
                  child: const Text('Simpan', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
