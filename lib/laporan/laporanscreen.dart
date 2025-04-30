import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
import 'package:flutter_application_kledo/laporan/aruskasscreen.dart';
import 'package:flutter_application_kledo/laporan/detailpenjualan.dart';
import 'package:flutter_application_kledo/laporan/labarugi.dart';
import 'package:flutter_application_kledo/laporan/neracalaporanscreen.dart';
import 'package:flutter_application_kledo/laporan/perubahanmodal.dart';
import 'package:flutter_application_kledo/laporan/ringkasanbank.dart';
import 'package:flutter_application_kledo/laporan/trialbalance.dart';

class LaporanPage extends StatelessWidget {
  final Map<String, List<String>> laporanKategori = {
    "Finansial": [
      "Neraca",
      "Arus Kas",
      "Laba Rugi",
      "Perubahan Modal",
      "Ringkasan Eksekutif",
      "Hutang Piutang per Kontak",
    ],
    "Akuntansi": [
      "Ringkasan Bank",
      "Buku Besar",
      "Jurnal",
      "Trial Balance",
    ],
    "Penjualan": [
      "Detail Penjualan",
      "Umur Piutang",
      "Tagihan Pelanggan",
      "Profibilitas Produk",
      "Pendapatan per Pelanggan",
      "Penjualan per Kategori Produk",
      "Penjualan per Produk",
      "Pemesanan per Produk",
      "Penjualan per Sales Person",
      "Pengiriman Penjualan",
      "Ongkos Kirim per Ekspedisi",
      "Pelunasan Pembayaran Tagihan",
      "Penjualan Produk per Pelanggan",
      "Penjualan per Produk",
    ],
    "Pembelian": [
      "Detail Pembelian",
      "Umur Hutang",
      "Tagihan Vendor",
      "Pembelian per Produk",
      "Pembelian per Vendor",
      "Pengiriman Pembelian",
      "Pelunasan Pembayaran Tagihan Pembelian",
      "Pembelian Produk per Vendor",
      "Pembelian per Periode",
    ],
    "Biaya": [
      "Biaya per Kontak",
      "Detil Klaim Biaya",
    ],
    "Pajak": [
      "Pajak Penjualan",
      "Pajaka Pemotongan",
    ],
    "Inventori": [
      "Ringkasan Inventori",
      "Pergerakan Stok Inventori",
      "Ringkasan Stok Gudang",
      "Pergerakan Stok Gudang",
      "Laporan Produksi",
      "Laporan Transfer Gudang",
      "Laporan Mutasi Nomor Seri",
      "Laporan Stok Nomor Seri per Gudang",
      "Laporan Nomor Produksi Segera Kadaluarsa",
      "Laporan Sisa Umur Nomor Produksi",
      "Laporan Riwayat Nomor Seri",
    ],
    "Aset Tetap": [
      "Ringkasan Aset Tetap",
      "Detil Aset Tetap",
      "Pelepasan Aset",
    ],
    "Anggaran": [
      "Anggaran Laba Rugi",
    ],
    "Lain-lain": [
      "Attachment",
      "Ekspor",
      "Import",
    ],
  };

 LaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const KledoDrawer(), // Tambahkan drawer kalau diperlukan
      appBar: AppBar(
        title: const Text('Laporan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: laporanKategori.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    ...entry.value.map((laporan) => Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.star_border),
                              title: Text(laporan),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                if (laporan == "Neraca") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NeracaPage(),
                                    ),
                                  );
                                } else if (laporan == "Arus Kas") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArusKasPage(),
                                    ),
                                  );
                                } else if (laporan == "Laba Rugi") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LabaRugiPage(),
                                    ),
                                  );
                                } else  if (laporan == "Perubahan Modal") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PerubahanModalPage()
                                      )
                                  );
                                } else if (laporan == "Ringkasan Bank"){
                                  Navigator.push
                                  (context,
                                   MaterialPageRoute(
                                    builder: (context) => const RingkasanBankPage()
                                    )
                                  );
                                } else if (laporan == "Trial Balance"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TrialBalancePage()
                                      )
                                  );
                                } else if(laporan == "Detail Penjualan"){
                                  Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                    builder: (context) => const DetailPenjualanPage()
                                    )
                                  );
                                }
                                // Aksi ketika laporan diklik
                              },
                            ),
                            const Divider(height: 1),
                          ],
                        )),
                    const SizedBox(height: 8), // Spasi antar kategori
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}