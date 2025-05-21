import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BankDetailPage extends StatefulWidget {
  final Map<String, dynamic> bank;

  BankDetailPage({required this.bank});

  @override
  _BankDetailPageState createState() => _BankDetailPageState();
}

class _BankDetailPageState extends State<BankDetailPage> {
  late Map<String, dynamic> bank;

  @override
  void initState() {
    super.initState();
    bank = widget.bank;
  }

  Future<void> _editBankDialog() async {
    TextEditingController namaBankController =
        TextEditingController(text: bank['nama_bank']);
    TextEditingController namaRekeningController =
        TextEditingController(text: bank['nama_rekening']);
    TextEditingController noRekeningController =
        TextEditingController(text: bank['no_rekening']);

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Data Bank'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaBankController,
                decoration: InputDecoration(labelText: 'Nama Bank'),
              ),
              TextField(
                controller: namaRekeningController,
                decoration: InputDecoration(labelText: 'Nama Rekening'),
              ),
              TextField(
                controller: noRekeningController,
                decoration: InputDecoration(labelText: 'No. Rekening'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              final response = await http.post(
                Uri.parse(
                    'http://192.168.1.13/CONNNECT/JSON/bank/edit_bank.php'),
                body: {
                  'id': bank['id'].toString(),
                  'nama_bank': namaBankController.text,
                  'nama_rekening': namaRekeningController.text,
                  'no_rekening': noRekeningController.text,
                },
              );

              if (response.statusCode == 200) {
                setState(() {
                  bank['nama_bank'] = namaBankController.text;
                  bank['nama_rekening'] = namaRekeningController.text;
                  bank['no_rekening'] = noRekeningController.text;
                });
                Navigator.pop(context, true);
              } else {
                Navigator.pop(context, false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal update data')),
                );
              }
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil diupdate')),
      );
    }
  }

  Future<void> _deleteBank() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Hapus Data'),
        content: Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Batal')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final response = await http.post(
        Uri.parse('http://192.168.1.13/CONNNECT/JSON/bank/delete_bank.php'),
        body: {'id': bank['id'].toString()},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil menghapus data'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pop(context, true); // kembali dan trigger refresh
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail Bank', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          PopupMenuButton<String>(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) {
              if (value == 'edit') _editBankDialog();
              if (value == 'delete') _deleteBank();
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                  value: 'edit',
                  child: Row(children: [
                    Icon(Icons.edit),
                    SizedBox(width: 10),
                    Text('Edit')
                  ])),
              PopupMenuItem(
                  value: 'delete',
                  child: Row(children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Delete')
                  ])),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoTile(
                    icon: Icons.account_balance,
                    label: 'Nama Bank',
                    value: bank['nama_bank'] ?? ''),
                _buildInfoTile(
                    icon: Icons.person,
                    label: 'Nama Rekening',
                    value: bank['nama_rekening'] ?? ''),
                _buildInfoTile(
                    icon: Icons.credit_card,
                    label: 'No. Rekening',
                    value: bank['no_rekening'] ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: Icon(icon, color: Colors.blue),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(value, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(),
        SizedBox(height: 16),
      ],
    );
  }
}
