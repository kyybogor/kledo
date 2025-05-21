import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahCustomerScreen extends StatefulWidget {
  const TambahCustomerScreen({Key? key}) : super(key: key);

  @override
  State<TambahCustomerScreen> createState() => _TambahCustomerScreenState();
}

class _TambahCustomerScreenState extends State<TambahCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String selectedJenis = 'Customer';
  final List<String> jenisList = ['Customer', 'Supplier'];

  Future<void> _saveData() async {
    final data = {
      "jenis": selectedJenis,
      "name": _nameController.text,
      "phone": _phoneController.text,
      "address": _addressController.text,
    };

    final response = await http.post(
      Uri.parse("http://192.168.1.10/connect/JSON/add_customer.php"), // ganti IP jika perlu
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["success"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil disimpan")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result["message"])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menyimpan data ke server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Tambah Customer/Supplier",
              style: TextStyle(color: Colors.blue, fontSize: 20)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedJenis,
              items: jenisList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedJenis = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Jenis',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    OutlinedButton(
      onPressed: () => Navigator.pop(context),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey[700],
        side: BorderSide(color: Colors.grey[400]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: const Text("Cancel"),
    ),
    const SizedBox(width: 12),
    ElevatedButton(
      onPressed: _saveData,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        elevation: 2,
      ),
      child: const Text("Save"),
    ),
  ],
),

          ],
        ),
      ),
    );
  }
}
