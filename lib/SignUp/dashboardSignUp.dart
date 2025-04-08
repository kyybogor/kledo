import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PackageSelectionPage(),
  ));
}

class PackageSelectionPage extends StatefulWidget {
  const PackageSelectionPage({super.key});

  @override
  State<PackageSelectionPage> createState() => _PackageSelectionPageState();
}

class _PackageSelectionPageState extends State<PackageSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, left: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0E4DA4), Color(0xFF2E8BEF)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftar!',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Daftar gratis, langsung aktif!',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Silakan pilih paket',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPackageCard(
                    title: 'Champion Free Trial',
                    subtitle: 'Coba gratis 14 hari',
                    description:
                        'Fitur untuk enterprise: multi currency, budgeting, approval, konsolidasi anak perusahaan',
                    target: 'Cocok untuk Bisnis Enterprise',
                    color: Colors.orange.shade400,
                  ),
                  _buildPackageCard(
                    title: 'Elite Free Trial',
                    subtitle: 'Coba gratis 14 hari',
                    description:
                        '5 user, 5 gudang, produk manufaktur, konversi satuan, harga bertingkat, laporan profitabilitas, marketplace connect',
                    target: 'Cocok untuk bisnis berkembang',
                    color: Colors.blueGrey.shade400,
                  ),
                  _buildPackageCard(
                    title: 'Pro Free Trial',
                    subtitle: 'Coba gratis 14 hari',
                    description:
                        'Alur bisnis lengkap, 3 user, 1 gudang, manajemen stok, multi proyek, 50 laporan keuangan & bisnis',
                    target: 'Cocok untuk bisnis baru',
                    color: Colors.brown.shade400,
                  ),
                  _buildPackageCard(
                    title: 'Free',
                    subtitle: 'Gratis selamanya',
                    description:
                        '1 user, fitur dasar software akuntansi, 10 laporan keuangan',
                    target: 'Cocok untuk usaha mikro/perorangan',
                    color: Colors.blue.shade600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String subtitle,
    required String description,
    required String target,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.white),
          Text(
            target,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}