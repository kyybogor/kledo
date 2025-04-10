import 'package:flutter/material.dart';
import 'package:flutter_application_kledo/belumdibayar/belumdibayarscreen.dart';
import 'package:flutter_application_kledo/tagihan/dibayarsebagianscreen.dart';

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tagihanList = [
      {
        "label": "Belum Dibayar",
        "count": 3,
        "icon": Icons.money_off,
        "color": Colors.red
      },
      {
        "label": "Dibayar Sebagian",
        "count": 1,
        "icon": Icons.payments_outlined,
        "color": Colors.orange
      },
      {
        "label": "Sudah Dibayar",
        "count": 6,
        "icon": Icons.check_circle_outline,
        "color": Colors.green
      },
      {
        "label": "Jatuh Tempo",
        "count": 1,
        "icon": Icons.warning_amber,
        "color": Colors.blue
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tagihan"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView.builder(
        itemCount: tagihanList.length,
        itemBuilder: (context, index) {
          final item = tagihanList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: item['color'],
              child: Icon(item['icon'], color: Colors.white),
            ),
            title: Text(item['label']),
            trailing: Text("${item['count']}"),
            onTap: () {
              if (item['label'] == "Belum Dibayar") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BelumDibayar()),
                );
              } else if (item['label'] == "Dibayar Sebagian") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DibayarSebagian()),
                );
              }
              // Tambahkan else if untuk label lainnya jika perlu
            },
          );
        },
      ),
    );
  }
}
