import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
import 'package:flutter_application_kledo/kas%20&%20bank/kasscreen.dart';


class KasDanBank extends StatelessWidget {
  const KasDanBank({super.key});

  @override
  Widget build(BuildContext context) {
    final kasData = [
      {
        "nama": "Kas",
        "kode": "1-10001",
        "warna": Colors.red,
        "nominal": "62.677.047",
        "halaman": const Kasscreen(),
      },
      {
        "nama": "Rekening Bank",
        "kode": "1-10002",
        "warna": Colors.pink,
        "nominal": "9.869.961",
        //"halaman": const RekeningPage(),
      },
      {
        "nama": "Giro",
        "kode": "1-10003",
        "warna": Colors.purple,
        "nominal": "37.031.038",
        //"halaman": const GiroPage(),
      },
    ];

    return Scaffold(
      drawer: const KledoDrawer(),
      appBar: AppBar(
        title: const Text('Kas & Bank'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: kasData.length,
              itemBuilder: (context, index) {
                final data = kasData[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: data['warna'] as Color,
                  ),
                  title: Text(data['nama'] as String),
                  subtitle: Text(data['kode'] as String),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: (data['warna'] as Color).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data['nominal'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => data['halaman'] as Widget,
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
