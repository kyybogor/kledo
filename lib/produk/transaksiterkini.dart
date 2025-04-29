import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model untuk Transaksi
class Transaksi {
  final String invoice;
  final String nama;
  final String date;
  final String total;

  Transaksi({
    required this.invoice,
    required this.nama,
    required this.date,
    required this.total,
  });

  // Fungsi untuk mem-parsing JSON menjadi objek Transaksi
  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      invoice: json['invoice'],
      nama: json['nama'],
      date: json['date'] ?? 'Tanggal Tidak Tersedia',
      total: json['total'],
    );
  }
}

Future<List<Transaksi>> fetchTransaksi() async {
  final response = await http.get(Uri.parse('http://192.168.1.25/Hiyami/transaksiterikini.php'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];

    return data.map((item) => Transaksi.fromJson(item)).toList();
  } else {
    throw Exception('Gagal memuat data transaksi');
  }
}

// Halaman untuk menampilkan daftar transaksi terkini
class TransaksiTerkiniPage extends StatefulWidget {
  const TransaksiTerkiniPage({super.key});

  @override
  _TransaksiTerkiniPageState createState() => _TransaksiTerkiniPageState();
}

class _TransaksiTerkiniPageState extends State<TransaksiTerkiniPage> {
  late Future<List<Transaksi>> futureTransaksi;

  @override
  void initState() {
    super.initState();
    futureTransaksi = fetchTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Transaksi Terkini'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Transaksi>>(
        future: futureTransaksi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data transaksi'));
          } else {
            final transaksiList = snapshot.data!;

            return ListView.builder(
              itemCount: transaksiList.length,
              itemBuilder: (context, index) {
                final trx = transaksiList[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trx.invoice, style: const TextStyle(fontWeight: FontWeight.w500)),
                      Text('- ${trx.nama}', style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(trx.date, style: const TextStyle(fontSize: 12)),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(trx.total, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    // Aksi ketika item di-tap (misalnya membuka detail transaksi)
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
