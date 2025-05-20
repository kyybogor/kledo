import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: DetailKlaimBiayaPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class DetailKlaimBiayaPage extends StatefulWidget {
  @override
  _DetailKlaimBiayaPageState createState() => _DetailKlaimBiayaPageState();
}

class _DetailKlaimBiayaPageState extends State<DetailKlaimBiayaPage> {
  List<Map<String, dynamic>> dataKlaim = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKlaimData();
  }

  Future<void> fetchKlaimData() async {
    final url = Uri.parse(
        "http://192.168.1.13/CONNNECT/JSON/klaim_api.php"); // ganti sesuai IP/host
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      setState(() {
        dataKlaim = decoded.cast<Map<String, dynamic>>();
        isLoading = false;
      });
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  @override
  Widget build(BuildContext context) {
    int total = dataKlaim.fold(0, (sum, item) => sum + (item['jumlah'] as int));

    Map<String, int> totalPerUsia = {
      '< 1 Bulan': 0,
      '1 Bulan': 0,
      '2 Bulan': 0,
      '3 Bulan': 0,
      '> 3 Bulan': 0,
    };

    for (var klaim in dataKlaim) {
      for (var det in klaim['detail']) {
        totalPerUsia[det['usia']] =
            (totalPerUsia[det['usia']] ?? 0) + (det['jumlah'] as int);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detil Klaim Biaya', style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              itemCount: dataKlaim.length + 1,
              separatorBuilder: (context, index) =>
                  Divider(height: 0.9, color: Colors.grey[300]),
              itemBuilder: (context, index) {
                if (index < dataKlaim.length) {
                  var item = dataKlaim[index];
                  return ListTile(
                    dense: true,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    title: Text(item['nama'], style: TextStyle(fontSize: 14)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            formatRupiah(item['jumlah']),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.chevron_right,
                            size: 20, color: Colors.grey[600]),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPerOrangPage(
                            nama: item['nama'],
                            detail:
                                List<Map<String, dynamic>>.from(item['detail']),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      children: [
                        Divider(thickness: 1),
                        sectionRow('Total', total, isBold: true),
                        ...totalPerUsia.entries.map(
                          (e) => sectionRow(e.key, e.value),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
    );
  }

  Widget sectionRow(String label, int jumlah, {bool isBold = false}) {
    return Column(
      children: [
        ListTile(
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          trailing: Text(
            formatRupiah(jumlah),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(height: 0.5, color: Colors.grey[300]),
      ],
    );
  }

  String formatRupiah(int angka) {
    return angka.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

class DetailPerOrangPage extends StatelessWidget {
  final String nama;
  final List<Map<String, dynamic>> detail;

  DetailPerOrangPage({required this.nama, required this.detail});

  @override
  Widget build(BuildContext context) {
    int total = detail.fold(0, (sum, item) => sum + (item['jumlah'] as int));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(nama.length > 20 ? nama.substring(0, 20) + '...' : nama,
            style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'Detil Klaim Biaya',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: detail.length + 1,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                if (index < detail.length) {
                  var item = detail[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['usia']),
                        Text(
                          formatRupiah(item['jumlah']),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(formatRupiah(total),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatRupiah(int angka) {
    return angka.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}
