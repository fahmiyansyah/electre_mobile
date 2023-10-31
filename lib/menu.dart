import 'package:electre_app/calculate1.dart';
import 'package:electre_app/calculate2.dart';
import 'package:electre_app/calculate3.dart';
import 'package:electre_app/electre_alternatif.dart';
import 'package:electre_app/electre_weight.dart';
import 'package:electre_app/model.dart';
import 'package:flutter/material.dart';
import 'electre_criteria.dart'; // Import halaman kriteria

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom dalam grid
          ),
          itemCount:
              6, // Jumlah menu items, termasuk "Electre 1", "Electre 2", dan "Electre 3"
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectreWeight(),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectreCriteria(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectreAlternatif(),
                    ),
                  );
                }
                // Tambahkan pengkondisian untuk "Electre 1", "Electre 2", dan "Electre 3"
                else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Electre1(),
                    ),
                  );
                } else if (index == 4) {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Electre2(),
                    ),
                  );
                } else if (index == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Electre3(),
                    ),
                  );
                }
              },
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    getMenuTitle(index),
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String getMenuTitle(int index) {
    switch (index) {
      case 0:
        return 'Add Weight';
      case 1:
        return 'Add Criteria';
      case 2:
        return 'Add Alternatif';
      case 3:
        return 'Electre 1';
      case 4:
        return 'Electre 2';
      case 5:
        return 'Electre 3';
      default:
        return '';
    }
  }
}
