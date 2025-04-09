import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TagihanPage(),
  ));
}

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  final List<Map<String, dynamic>> tagihanList = const [
    {"label": "Belum Dibayar", "count": 26, "color": Colors.pink},
    {"label": "Dibayar Sebagian", "count": 1, "color": Colors.amber},
    {"label": "Lunas", "count": 19, "color": Colors.green},
    {"label": "Void", "count": 0, "color": Colors.grey},
    {"label": "Jatuh Tempo", "count": 0, "color": Colors.black},
    {"label": "Retur", "count": 0, "color": Colors.orange},
    {"label": "Transaksi Berulang", "count": 0, "color": Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(), // Kosongkan drawer sementara
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Tagihan", style: TextStyle(color: Colors.blue)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: tagihanList.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = tagihanList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item['color'],
                    radius: 10,
                  ),
                  title: Text(item['label']),
                  trailing: Text("${item['count']}"),
                  onTap: () {
                    // TODO: Tambahkan navigasi jika diperlukan
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
