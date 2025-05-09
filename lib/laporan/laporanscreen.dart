import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart';
import 'package:flutter_application_kledo/inventori/ringkasaninventori.dart';
import 'package:flutter_application_kledo/inventori/ringkasanstokgudang.dart';
import 'package:flutter_application_kledo/laporan/aruskasscreen.dart';
import 'package:flutter_application_kledo/laporan/bukubesar.dart';
import 'package:flutter_application_kledo/laporan/jurnal.dart';
import 'package:flutter_application_kledo/laporan/penjualan/detailpenjualan.dart';
import 'package:flutter_application_kledo/laporan/hutangpiutangperkontak.dart';
import 'package:flutter_application_kledo/laporan/labarugi.dart';
import 'package:flutter_application_kledo/laporan/neracalaporanscreen.dart';
import 'package:flutter_application_kledo/laporan/penjualan/pelunasanpembayarantagihan.dart';
import 'package:flutter_application_kledo/laporan/penjualan/pendapatanperpelanggan.dart';
import 'package:flutter_application_kledo/laporan/penjualan/penjualanperproduk.dart';
import 'package:flutter_application_kledo/laporan/penjualan/penjualanprodukperpelanggan.dart';
import 'package:flutter_application_kledo/laporan/perubahanmodal.dart';
import 'package:flutter_application_kledo/laporan/penjualan/profitabilitas.dart';
import 'package:flutter_application_kledo/laporan/ringkasan_bank.dart';
import 'package:flutter_application_kledo/laporan/ringkasaneksekutif.dart';
import 'package:flutter_application_kledo/laporan/penjualan/tagihanpelanggan.dart';
import 'package:flutter_application_kledo/laporan/trialbalance.dart';
import 'package:flutter_application_kledo/laporanAssetTetap/detailLaporanAset.dart';
import 'package:flutter_application_kledo/laporanAssetTetap/pelepasanaset.dart';
import 'package:flutter_application_kledo/laporanAssetTetap/ringkasanasset.dart';
import 'package:flutter_application_kledo/pajak/pajakpemotongan.dart';
import 'package:flutter_application_kledo/pajak/pajakpenjualan.dart';

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
      "Penjualan per Periode",
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
      "Pajak Pemotongan",
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
                                      builder: (context) =>
                                          const LabaRugiPage(),
                                    ),
                                  );
                                } else if (laporan == "Perubahan Modal") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PerubahanModalPage()));
                                } else if (laporan == "Trial Balance") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TrialBalancePage()));
                                } else if (laporan == "Detail Penjualan") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const DetailPenjualanPage()));
                                } else if (laporan == "Penjualan per Produk") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const PenjualanPerProdukPage()));
                                } else if (laporan == "Profibilitas Produk") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ProfitabilitasProdukPage()));
                                } else if(laporan == "Tagihan Pelanggan"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TagihanPelangganPage()));
                                } else if(laporan == "Ringkasan Eksekutif"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const RingkasanEksekutif()
                                    )
                                  );
                                } else if(laporan == "Hutang Piutang per Kontak"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Hutangpiutangperkontak()
                                      )
                                  );
                                }else if(laporan == "Pelunasan Pembayaran Tagihan"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PelunasanListPage()
                                    )
                                  );
                                } else if(laporan == "Ringkasan Inventori"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const InventorySummaryPage()
                                    )
                                  );
                                } else if(laporan == "Ringkasan Aset Tetap"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AsetRingkasanPage()
                                    )
                                  );
                                }else if(laporan == "Pelepasan Aset"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PelepasanAsetPage()
                                    )
                                  );
                                } else if(laporan == "Detil Aset Tetap"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DetilAsetTetapPage(),
                                    )
                                  );
                                } else if(laporan == "Ringkasan Stok Gudang"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RingkasanStokGudangPage(),
                                    )
                                  );
                                } else if(laporan == "Pajak Penjualan"){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PajakPenjualanPage(),
                                    )
                                  );
                                } else if(laporan == "Ringkasan Bank"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const RingkasanBank(),
                                    )
                                  );
                                } else if(laporan == "Buku Besar"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BukuBesarScreen(),
                                    )
                                  );
                                } else if(laporan == "Pajak Pemotongan"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const PajakPemotonganPage(),
                                    )
                                  );
                                } else if(laporan == "Pendapatan per Pelanggan"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const PendapatanPerpelangganPage(),
                                    )
                                  );
                                } else if(laporan == "Jurnal"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const JurnalListPage(),
                                    )
                                  );
                                } else if(laporan == "Penjualan Produk per Pelanggan"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SalesListPage(),
                                    )
                                  );
                                }
                              },
                            ),
                            const Divider(height: 1),
                          ],
                        )),
                    const SizedBox(height: 8),
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
