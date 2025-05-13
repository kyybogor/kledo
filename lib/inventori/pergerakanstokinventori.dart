import 'package:flutter/material.dart';

class InventoryMovementPage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {'name': 'Chelsea Boots', 'code': 'CB1'},
    {'name': 'Kneel High Boots', 'code': 'KH1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergerakan Stok Inventori'),
        leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ListTile(
                  title: Text(item['name']!),
                  subtitle: Text(item['code']!),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Text('0'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InventoryDetailPage(
                          name: item['name']!,
                          code: item['code']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('0'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.download),
        onPressed: () {},
      ),
    );
  }
}

class InventoryDetailPage extends StatelessWidget {
  final String name;
  final String code;

  const InventoryDetailPage({required this.name, required this.code});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> details = [
      {'label': 'Kode', 'value': code},
      {'label': 'Kuantitas Awal', 'value': '0'},
      {'label': 'Pergerakan Kuantitas', 'value': '0'},
      {'label': 'Kuantitas Akhir', 'value': '0'},
      {'label': 'Nilai Awal', 'value': '0'},
      {'label': 'Pergerakan Nilai', 'value': '0'},
      {'label': 'Nilai Akhir', 'value': '0'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: BackButton(),
      ),
      body: ListView(
        children: [
          ...details.map((item) {
            return ListTile(
              title: Text(item['label']!),
              trailing: Text(item['value']!),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lihat detail pergerakan"),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Buka Inventori"),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
