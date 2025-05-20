import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

import 'bank_detail_page.dart';

class KasBankPage extends StatefulWidget {
  @override
  _KasBankPageState createState() => _KasBankPageState();
}

class _KasBankPageState extends State<KasBankPage> {
  List<Map<String, dynamic>> bankData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBankData();
  }

  Future<void> fetchBankData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
        Uri.parse('http://192.168.1.13/CONNNECT/JSON/bank/get_bank_data.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        bankData = data.cast<Map<String, dynamic>>();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Gagal mengambil data dari server');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data dari server')),
      );
    }
  }

  Future<void> _showAddBankDialog() async {
    final _formKey = GlobalKey<FormState>();
    String namaBank = '';
    String namaRekening = '';
    String noRekening = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Rekening Bank'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nama Bank'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Masukkan nama bank'
                        : null,
                    onSaved: (value) => namaBank = value!.trim(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nama Rekening'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Masukkan nama rekening'
                        : null,
                    onSaved: (value) => namaRekening = value!.trim(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'No. Rekening'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => value == null || value.isEmpty
                        ? 'Masukkan no. rekening'
                        : null,
                    onSaved: (value) => noRekening = value!.trim(),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context);
                  await _submitNewBank(namaBank, namaRekening, noRekening);
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitNewBank(
      String namaBank, String namaRekening, String noRekening) async {
    final url =
        Uri.parse('http://192.168.1.13/CONNNECT/JSON/bank/insert_bank.php');
    try {
      final response = await http.post(url, body: {
        'nama_bank': namaBank,
        'nama_rekening': namaRekening,
        'no_rekening': noRekening,
      });

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil menambahkan rekening')),
        );
        fetchBankData(); // Refresh list setelah insert berhasil
      } else {
        String errorMsg = data['error'] ?? 'Gagal menambahkan rekening';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Kas & Bank', style: TextStyle(color: Colors.blue)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.5,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: bankData.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final bank = bankData[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                        ),
                        title: Text('${bank['nama_bank']}'),
                        subtitle: Text('${bank['no_rekening']}'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BankDetailPage(bank: bank),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBankDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
