import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BelumDibayarPage(),
  ));
}

class BelumDibayarPage extends StatelessWidget {
  const BelumDibayarPage({super.key});

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
        title:
            const Text("Belum Dibayar", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        centerTitle: true,
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InvoiceDetailPage(invoice: invoice),
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
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class InvoiceDetailPage extends StatelessWidget {
  final Map<String, String> invoice;

  const InvoiceDetailPage({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(invoice["name"] ?? "Detail Tagihan"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Invoice: ${invoice["invoice"]}"),
                const SizedBox(height: 8),
                Text("Tanggal: ${invoice["date"]}"),
                const SizedBox(height: 8),
                Text("Total Tagihan: ${invoice["amount"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.pink)),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    _showPaymentBottomSheet(context);
                  },
                  icon: const Icon(Icons.payment),
                  label: const Text("Terima Pembayaran"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text("Terima Pembayaran",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: "Total Dibayar",
                  prefixText: "Rp ",
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Tanggal Transaksi",
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: "Kas",
                items: const [
                  DropdownMenuItem(value: "Kas", child: Text("Kas")),
                  DropdownMenuItem(value: "Bank", child: Text("Bank")),
                ],
                onChanged: (value) {},
                decoration: const InputDecoration(
                  labelText: "Dibayar ke",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12)),
                child: const Text("Simpan Pembayaran"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
