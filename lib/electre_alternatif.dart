import 'package:electre_app/add_alternatif.dart';
import 'package:electre_app/data.dart';
import 'package:flutter/material.dart';
import 'package:electre_app/model.dart';

class ElectreAlternatif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Alternatif'),
      ),
      body: ListView.builder(
        itemCount: alternatifData.length,
        itemBuilder: (context, index) {
          AlternatifModel alternatif = alternatifData[index];

          return ListTile(
            title: Text(alternatif.nama),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: alternatif.nilaiKriteria.entries.map((entry) {
                // Ganti label sesuai dengan kriteria (Misalnya: Nilai IPK => K1)
                String kriteriaLabel = _getKriteriaLabel(entry.key);
                return Text('$kriteriaLabel: ${entry.value}');
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAlternatifPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _getKriteriaLabel(String kriteria) {
    // Fungsi ini mengubah label kriteria menjadi K1, K2, K3, K4 sesuai dengan kriteria yang ada
    switch (kriteria) {
      case 'IPK':
        return 'K1';
      case 'Penghasilan Pertahun':
        return 'K2';
      case 'Jumlah Tanggungan':
        return 'K3';
      case 'Pekerjaan Orang Tua':
        return 'K4';
      default:
        return kriteria;
    }
  }
}
