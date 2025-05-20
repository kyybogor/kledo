import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'dart:html' as html; // Untuk platform Web

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _hargaJualController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  File? _imageFile;
  html.File? _webImageFile;
  Uint8List? _webImageBytes;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  // Kategori
  List<String> _kategoriList = [];
  String? _selectedKategori;

  Future<void> _fetchKategori() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.8/hiyami/kategori.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _kategoriList = data.map((e) => e['nama_kategori'].toString()).toList();
        });
      } else {
        throw Exception('Gagal mengambil kategori');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saat mengambil kategori: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchKategori();
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) return;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]!);
        reader.onLoadEnd.listen((e) {
          setState(() {
            _webImageFile = files[0];
            _webImageBytes = reader.result as Uint8List?;
          });
        });
      });
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> _simpanProduk() async {
    if (!_formKey.currentState!.validate()) return;

    if (_imageFile == null && _webImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih gambar terlebih dahulu')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse('http://192.168.1.8/hiyami/tambah_produk.php');

    var request = http.MultipartRequest('POST', url)
      ..fields['name'] = _namaController.text
      ..fields['code'] = _kodeController.text
      ..fields['kategori'] = _selectedKategori ?? ''
      ..fields['harga_jual'] = _hargaJualController.text
      ..fields['stok'] = _stokController.text;

    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _imageFile!.path,
        filename: _imageFile!.path.split('/').last,
      ));
    }

    if (_webImageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        _webImageBytes!,
        filename: _webImageFile!.name,
      ));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final respJson = jsonDecode(respStr);
        if (respJson['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produk berhasil ditambahkan')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(respJson['message'])),
          );
        }
      } else {
        throw Exception('Gagal mengirim data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _roundedInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: _roundedInputDecoration('Nama Produk'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kodeController,
                decoration: _roundedInputDecoration('Kode Produk'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedKategori,
                decoration: _roundedInputDecoration('Kategori Produk'),
                items: _kategoriList.map((kategori) {
                  return DropdownMenuItem<String>(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedKategori = value!;
                  });
                },
                validator: (value) => value == null ? 'Pilih kategori' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _hargaJualController,
                decoration: _roundedInputDecoration('Harga Jual'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _stokController,
                decoration: _roundedInputDecoration('Stok'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pilih Gambar'),
              ),
              const SizedBox(height: 20),
              if (_imageFile != null || _webImageBytes != null)
                Column(
                  children: [
                    const Text('Pratinjau Gambar:'),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
                          : Image.memory(_webImageBytes!, fit: BoxFit.cover),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.end, // Tombol berada di sebelah kanan
  children: [
    // Tombol Cancel
    ElevatedButton(
      onPressed: () {
        // Logika untuk tombol Cancel
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
      ),
      child: const Text('Cancel'),
    ),
    const SizedBox(width: 10), // Menambahkan jarak antara tombol Cancel dan Simpan
    ElevatedButton(
      onPressed: _isLoading ? null : _simpanProduk,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Simpan', style: TextStyle(color: Colors.white),),
    ),
  ],
)
            ],
          ),
        ),
      ),
    );
  }
}
