import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BelumDibayar(),
  ));
}

class BelumDibayar extends StatelessWidget {
  const BelumDibayar({super.key});

  final List<Map<String, String>> invoices = const [
    {
      "name": "Hilda Suartini M.M. Prastuti",
      "invoice": "INV/00042",
      "date": "04/04/2025",
      "amount": "Rp 597.000"
    },
    {
      "name": "Rini Rahayu Mandala",
      "invoice": "INV/00041",
      "date": "04/04/2025",
      "amount": "Rp 2.003.570"
    },
    {
      "name": "Ade Lutfan Firgantoro M.Farm Fujiati",
      "invoice": "INV/00044",
      "date": "03/04/2025",
      "amount": "Rp 998.000"
    },
    {
      "name": "POS Customer",
      "invoice": "INV/00040",
      "date": "03/04/2025",
      "amount": "Rp 2.775.750"
    },
    {
      "name": "Jati Tarihoran Lazuardi",
      "invoice": "INV/00039",
      "date": "02/04/2025",
      "amount": "Rp 1.597.000"
    },
    {
      "name": "Lurhur Tampubolon Thamrin",
      "invoice": "INV/00038",
      "date": "01/04/2025",
      "amount": "Rp 1.074.330"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // <-- Judul ditengah
        title: const Text(
          "Belum Dibayar",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.blue),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.blue),
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
                hintText: "Cari",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("April 2025",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return ListTile(
                  title: Text(invoice["name"] ?? ""),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(invoice["invoice"] ?? ""),
                      Text(invoice["date"] ?? ""),
                    ],
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      invoice["amount"] ?? "",
                      style: const TextStyle(color: Colors.pink),
                    ),
                  ),
                  onTap: () {},
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
