import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hayami_app/customer/editcustomer.dart';
import 'package:http/http.dart' as http;

class Customerdetailscreen extends StatelessWidget {
  final Map<String, dynamic> customer;

  const Customerdetailscreen({Key? key, required this.customer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Detail Customer", style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        elevation: 1,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.blue),
            onSelected: (value) async {
              if (value == 'edit') {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditCustomerScreen(customer: customer),
                  ),
                );

                if (result != null && result is Map<String, dynamic>) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Data berhasil diperbarui")),
                  );
                  Navigator.of(context)
                      .pop(result); // kirim data edit ke Customerscreen
                }
              } else if (value == 'delete') {
                _confirmDelete(context);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            children: [
              CustomTile(
                icon: Icons.person,
                title: 'Nama',
                subtitle: customer['name'] ?? '-',
              ),
              const Divider(),
              CustomTile(
                icon: Icons.category,
                title: 'Jenis',
                subtitle: customer['jenis'] ?? '-',
              ),
              const Divider(),
              CustomTile(
                icon: Icons.phone,
                title: 'Telepon',
                subtitle: customer['phone'] ?? '-',
              ),
              const Divider(),
              CustomTile(
                icon: Icons.location_on,
                title: 'Alamat',
                subtitle: customer['address'] ?? '-',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Customer'),
        content: const Text('Apakah Anda yakin ingin menghapus customer ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
              _deleteCustomerFromAPI(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCustomerFromAPI(BuildContext context) async {
    final id = customer['id'];
    final url = Uri.parse(
        "http://192.168.1.10/connect/JSON/delete_customer.php"); // Ganti IP/server kamu

    try {
      final response = await http.post(url, body: {
        'id': id.toString(),
      });

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
        Navigator.of(context).pop('deleted'); // Kembali ke halaman sebelumnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Gagal menghapus data.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }
}

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CustomTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
