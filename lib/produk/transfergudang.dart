import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransferGudangPage extends StatefulWidget {
  @override
  _TransferGudangPageState createState() => _TransferGudangPageState();
}

class _TransferGudangPageState extends State<TransferGudangPage> {
  List<Map<String, String>> transfers = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchTransfers();
  }

  Future<void> fetchTransfers() async {
    final String url = 'http://192.168.1.23/hiyami/percobaan.php';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Memperoleh data transfer dari JSON
        List<Map<String, String>> loadedTransfers = [];
        for (var item in data) {
          final transfersList = item['transfers'] as List;
          for (var transfer in transfersList) {
            loadedTransfers.add({
              'kode': transfer['kode'] ?? 'N/A',
              'tanggal': transfer['tanggal'] ?? 'N/A',
            });
          }
        }

        setState(() {
          transfers = loadedTransfers;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('Transfer Gudang', style: TextStyle(color: Colors.blue[800])),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement filter action if needed
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue[800]),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? const Center(child: Text('Error fetching data.'))
              : ListView.builder(
                  itemCount: transfers.length,
                  itemBuilder: (context, index) {
                    final transfer = transfers[index];
                    return ListTile(
                      title: Text(transfer['kode']!),
                      subtitle: Text(transfer['tanggal']!),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Implement tap action if needed
                      },
                    );
                  },
                ),
    );
  }
}
