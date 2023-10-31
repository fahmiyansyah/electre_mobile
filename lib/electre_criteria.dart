import 'package:electre_app/add_data.dart';
import 'package:flutter/material.dart';
import 'package:electre_app/data.dart';
import 'package:electre_app/model.dart';

class ElectreCriteria extends StatefulWidget {
  @override
  _ElectreCriteriaState createState() => _ElectreCriteriaState();
}

class _ElectreCriteriaState extends State<ElectreCriteria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kriteria Data'),
      ),
      body: ListView(
        children: kriteriaData
            .map((kriteria) => buildCriterionTable(kriteria))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildCriterionTable(KriteriaModel kriteria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            kriteria.kriteria,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        DataTable(
          columns: <DataColumn>[
            DataColumn(label: Text('Scale')),
            DataColumn(label: Text('Bobot')),
          ],
          rows: kriteria.scales
              .map((scale) => DataRow(
                    cells: [
                      DataCell(Text(scale.value)),
                      DataCell(Text(scale.bobot.toString())),
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }
}
