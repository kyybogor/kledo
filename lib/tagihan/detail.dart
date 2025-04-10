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

  void _showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                          Text("Rp $amount",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 16),
                          const Text("Tgl transaksi"),
                          const SizedBox(height: 4),
                          Text(date, style: const TextStyle(fontSize: 16)),
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
                              backgroundColor: Colors.blueAccent,
                              minimumSize: const Size.fromHeight(45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "Simpan",
                              style: TextStyle(color: Colors.white),
                            ),
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
      backgroundColor: Colors.blue,
    );
  }

  void _onMenuSelected(String value) {
    // handle action menu
    print("Selected: $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tagihan"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(
                value: 'audit',
                child: ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Lihat Audit'),
                ),
              ),
              PopupMenuItem(
                value: 'ubah',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Ubah'),
                ),
              ),
              PopupMenuItem(
                value: 'hapus',
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Hapus'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
<<<<<<< HEAD
                        SizedBox(height: 4),
                        Text(
                          "UD Wijayanti Prabowo (Persero) Tbk",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Jl. Bass No. 719, Administrasi Jakarta Selatan",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "31540, Sultra",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
=======
                        const SizedBox(height: 4),
                        const Text("Perusahaan / Alamat",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 8),
>>>>>>> 2fff64705b75440fc29299d80cd5031b9f4c0b5f
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(date,
                                style: const TextStyle(color: Colors.white)),
                            const Spacer(),
                            const Icon(Icons.calendar_today,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            const Text("Jatuh tempo",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
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
=======
                  ListTile(
                    title: const Text("Item Produk"),
                    subtitle: const Text("Detail item..."),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("Rp $amount"),
                    ),
>>>>>>> 2fff64705b75440fc29299d80cd5031b9f4c0b5f
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
                            Text("Total",
<<<<<<< HEAD
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("Rp 9.980.000",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
=======
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Rp ...",
                                style: TextStyle(fontWeight: FontWeight.bold)),
>>>>>>> 2fff64705b75440fc29299d80cd5031b9f4c0b5f
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () => _showPaymentBottomSheet(context),
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
