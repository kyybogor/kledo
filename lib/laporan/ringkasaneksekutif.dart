import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RingkasanEksekutif extends StatefulWidget {
  const RingkasanEksekutif({super.key});

  @override
  State<RingkasanEksekutif> createState() => _RingkasanEksekutifState();
}

class _RingkasanEksekutifState extends State<RingkasanEksekutif> {
  Map<String, dynamic> data = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.9/connect/JSON/ringkasan_eksekutif.php'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Gagal memuat data');
    }
  }

  int parse(dynamic val) => int.tryParse(val?.toString() ?? '0') ?? 0;

  @override
  Widget build(BuildContext context) {
    int kasMasuk = parse(data['kas_masuk']);
    int kasKeluar = parse(data['kas_keluar']);
    int pendapatan = parse(data['pendapatan']);
    int biayaPenjualan = parse(data['biaya_penjualan']);
    int biaya = parse(data['biaya']);
    int aset = parse(data['aset']);
    int liabilitas = parse(data['liabilitas']);
    int modalpemilik = parse(data['modal_pemilik']);
    int jumlahtagihanditerbitkan = parse(data['jumlah_tagihan_diterbitkan']);
    int rataratanilaitagihan = parse(data['ratarata_nilai_tagihan']);
    int marginlabakotor = parse(data['margin_laba_kotor']);
    int marginlababersih = parse(data['margin_laba_bersih']);
    int pengembalianinvestasi = parse(data['pengembalian_investasi']);
    int rataratalamakonversipiutang = parse(data['ratarata_lama_konversi_piutang']);
    int rataratalamakonversihutang = parse(data['ratarata_lama_konversi_hutang']);
    int rasiohutangterhadapekutitas = parse(data['rasio_hutang_terhadap_ekuitas']);
    int rasioasetterhadapliabilitas = parse(data['rasio_aset_terhadap_liabilitas']);

    int perubahanKas = kasMasuk - kasKeluar;
    int labaKotor = pendapatan - biayaPenjualan;
    int labaBersih = labaKotor - biaya;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Eksekutif'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 10),
                sectionTitle('Kas'),
                buildRow('Kas masuk', kasMasuk),
                buildRow('Kas keluar', kasKeluar),
                buildRow('Perubahan kas', perubahanKas),
                buildRow('Saldo penutupan', perubahanKas),
                const SizedBox(height: 10),
                sectionTitle('Profitabilitas'),
                buildRow('Pendapatan', pendapatan),
                buildRow('Biaya penjualan', biayaPenjualan),
                buildRow('Laba kotor', labaKotor),
                buildRow('Biaya', biaya),
                buildRow('Laba bersih', labaBersih),
                const SizedBox(height: 10),
                sectionTitle('Neraca'),
                buildRow('Aset', aset),
                buildRow('Liabilitas', liabilitas),
                buildRow('Modal pemilik', modalpemilik),
                const SizedBox(height: 10),
                sectionTitle('Pendapatan'),
                buildRow('Jumlah tagihan diterbitkan', jumlahtagihanditerbitkan),
                buildRow('Rata-rata nilai tagihan', rataratanilaitagihan),
                const SizedBox(height: 10),
                sectionTitle('Peforma'),
                buildRow('Margin laba kotor', marginlabakotor),
                buildRow('Margin laba bersih', marginlababersih),
                buildRow('Pengembalian investasi / ROI (p.a.)', pengembalianinvestasi),
                const SizedBox(height: 10),
                sectionTitle('Posisi'),
                buildRow('Rata-rata lama konversi piutang', rataratalamakonversipiutang),
                buildRow('Rata-rata lama konversi hutang', rataratalamakonversihutang),
                buildRow('Rasio hutang terhadap ekutitas', rasiohutangterhadapekutitas),
                buildRow('Rasio aset terhadap liabilitas', rasioasetterhadapliabilitas),
              ],
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            heroTag: 'share',
            child: const Icon(Icons.share),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {},
            heroTag: 'download',
            child: const Icon(Icons.download),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String title, int value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value.toString().replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.'),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Container(
      width: double.infinity, // Memastikan selebar layar
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
