import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  void _showPaymentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar tinggi sheet bisa penuh
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      width: 40,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const Text(
                      "Terima pembayaran",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Dibayar"),
                          const SizedBox(height: 4),
                          const Text("Rp9.980.000",
                              style: TextStyle(fontSize: 16)),

                          const SizedBox(height: 16),
                          const Text("Tgl transaksi"),
                          const SizedBox(height: 4),
                          const Text("09/04/2025",
                              style: TextStyle(fontSize: 16)),

                          const SizedBox(height: 16),
                          const Text("Dibayar ke"),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            value: 'Kas',
                            items: ['Kas', 'Bank'].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (val) {},
                          ),

                          const SizedBox(height: 16),
                          const Text("Referensi"),
                          const TextField(),

                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              Icon(Icons.attach_file, size: 18),
                              SizedBox(width: 8),
                              Text("+ 0 attachment",
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size.fromHeight(45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Simpan",
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      backgroundColor: Colors.blue, // Background atas biru
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header tetap
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
              ),
            ),
            child: const Center(
              child: Text(
                "Tagihan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Konten scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Informasi Invoice
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightBlueAccent],
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("INV/00047",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("Novi Oktaviani Padmasari",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          "UD Wijayanti Prabowo (Persero) Tbk\nJl. Bass No. 719, Administrasi Jakarta Selatan\n31540, Sultra",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text("09/04/2025",
                                style: TextStyle(color: Colors.white)),
                            Spacer(),
                            Icon(Icons.calendar_today,
                                color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text("29/04/2025",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // List item
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: const Text("Chelsea Boots"),
                        subtitle: const Text("Ukuran M\n2 Pcs x Rp 499.000"),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.pink[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text("Rp 998.000"),
                        ),
                      );
                    },
                  ),

                  // Ringkasan
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal"),
                            Text("Rp 9.188.793"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("PPN 11%"),
                            Text("Rp 791.207"),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            Text("Rp 9.980.000",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sisa Tagihan"),
                            Text("Rp 9.980.000",
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        SizedBox(height: 16),
                        ExpansionTile(
                          title: Text("Informasi lainnya"),
                          children: [
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text("Gudang"),
                              subtitle: Text("Gudang Elektronik"),
                            ),
                            ListTile(
                              leading: Icon(Icons.attachment),
                              title: Text("0 Attachment"),
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tombol
          SafeArea(
            child: GestureDetector(
              onTap: _showPaymentBottomSheet,
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: const Center(
                  child: Text(
                    "Terima pembayaran",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
