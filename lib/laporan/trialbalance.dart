import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrialBalancePage extends StatefulWidget {
  @override
  _TrialBalancePageState createState() => _TrialBalancePageState();
}

class _TrialBalancePageState extends State<TrialBalancePage> {
  late Future<List<Map<String, dynamic>>> trialBalance;

  Future<List<Map<String, dynamic>>> fetchTrialBalance() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.23/hiyami/trial.php'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data
          .map((item) => {
                'category': item['category'],
                'accounts': List<Map<String, dynamic>>.from(item['accounts'])
              })
          .toList();
    } else {
      throw Exception('Failed to load trial balance');
    }
  }

  @override
  void initState() {
    super.initState();
    trialBalance = fetchTrialBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trial Balance'),
        centerTitle: true,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: trialBalance,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView(
              children: snapshot.data!.map<Widget>((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Text(
                        category['category'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...category['accounts'].map<Widget>((account) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(account['name']),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16), // ⬅️ Tambahan ini
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AccountDetailPage(account: account),
                                ),
                              );
                            },
                          ),
                          Divider(), // Garis pemisah antara setiap item
                        ],
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

class AccountDetailPage extends StatelessWidget {
  final Map<String, dynamic> account;

  const AccountDetailPage({super.key, required this.account});

  // Fungsi untuk menampilkan judul bagian
  Widget sectionTitle(String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Fungsi untuk menampilkan baris label dan nilai
  Widget valueRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]}.',
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pastikan semua nilai dikonversi ke int dengan aman
    final saldoAwalDebit =
        int.tryParse(account['saldo_awal_debit']?.toString() ?? '0') ?? 0;
    final saldoAwalKredit =
        int.tryParse(account['saldo_awal_kredit']?.toString() ?? '0') ?? 0;
    final pergerakanDebit =
        int.tryParse(account['debit']?.toString() ?? '0') ?? 0;
    final pergerakanKredit =
        int.tryParse(account['credit']?.toString() ?? '0') ?? 0;

    // Saldo akhir adalah saldo awal + pergerakan
    final saldoAkhirDebit = saldoAwalDebit + pergerakanDebit;
    final saldoAkhirKredit = saldoAwalKredit + pergerakanKredit;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: null,
        flexibleSpace: Align(
          alignment: Alignment.center,
          child: Text(
            account['name'],
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          sectionTitle("Saldo Awal"),
          valueRow("Debit", saldoAwalDebit),
          Divider(),
          valueRow("Kredit", saldoAwalKredit),
          sectionTitle("Pergerakan"),
          valueRow("Debit", pergerakanDebit),
          Divider(),
          valueRow("Kredit", pergerakanKredit),
          sectionTitle("Saldo Akhir"),
          valueRow("Debit", saldoAkhirDebit),
          Divider(),
          valueRow("Kredit", saldoAkhirKredit),
        ],
      ),
    );
  }
}
