import 'package:flutter/material.dart';

class DibayarSebagian extends StatelessWidget {
  const DibayarSebagian({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dibayar Sebagian"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 20),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.filter_list, color: Colors.black),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.yellow[100],
            padding: const EdgeInsets.all(12),
            child: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(Icons.info, color: Colors.black),
                  ),
                  const TextSpan(
                    text:
                        "  Data yang tampil saat ini adalah data dummy. Setelah Anda siap, ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "klik disini",
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(
                    text: " untuk mengosongkan data.",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xFFF1F1F1),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("March 2025",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            title: const Text("Mitra Prakosa Tarihoran Zulkarnain"),
            subtitle: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("INV/00016"),
                Text("11/03/2025"),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Rp 398.000"),
            ),
            onTap: () {
              // Tindakan jika item diklik
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
