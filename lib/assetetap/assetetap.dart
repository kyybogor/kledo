import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/Dashboard/dashboardscreen.dart' show KledoDrawer;

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> draftAssets = [
    {
      'name': 'Wisma Kantor BDG',
      'code': 'FA/00001',
      'date': '28/10/2024',
      'amount': 3800000
    },
  ];
  final List<Map<String, dynamic>> registeredAssets = [
    {
      'name': 'Wisma Kantor BDG',
      'code': 'FA/00001',
      'date': '28/10/2024',
      'amount': 3800000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    }
  ];
  final List<Map<String, dynamic>> soldAssets = [
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },
    {
      'name': 'Mobil Dinas B1299BK',
      'code': 'FA/00002',
      'date': '10/08/2024',
      'amount': 3000000
    },

  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget buildAssetList(List<Map<String, dynamic>> assets) {
    if (assets.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_late_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text("Data tidak ditemukan", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(asset['name'],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(asset['code']), Text(asset['date'])],
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                asset['amount'].toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: KledoDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Aset Tetap'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: 'DRAFT'),
            Tab(text: 'TERDAFTAR'),
            Tab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('TERJUAL/'),
                  Text('DILEPASKAN'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildAssetList(draftAssets),
                buildAssetList(registeredAssets),
                buildAssetList(soldAssets),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
