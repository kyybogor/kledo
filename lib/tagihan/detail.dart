import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  final String name;
  final String invoice;
  final String date;
  final String amount;

  const InvoicePage({
    super.key,
    required this.name,
    required this.invoice,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tagihan"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(invoice,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Perusahaan / Alamat",
                    style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(color: Colors.white)),
                    const Spacer(),
                    const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    const Text("Jatuh tempo", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("Item Produk"),
            subtitle: const Text("Detail item..."),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(amount),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal"),
                    Text("Rp ..."),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Rp ...", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
