import 'package:flutter/material.dart';
import 'package:electre_app/data.dart';
import 'package:electre_app/model.dart';
import 'package:electre_app/edit_weight.dart';

class ElectreWeight extends StatefulWidget {
  @override
  _KriteriaBobotPageState createState() => _KriteriaBobotPageState();
}

class _KriteriaBobotPageState extends State<ElectreWeight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kriteria Bobot'),
      ),
      body: ListView.builder(
        itemCount: kriteriaBobotData.length,
        itemBuilder: (context, index) {
          KriteriaBobotModel kriteriaBobot = kriteriaBobotData[index];
          return ListTile(
            title: Text(kriteriaBobot.kriteria.kriteria),
            subtitle: Text('Bobot: ${kriteriaBobot.bobot}'),
            trailing: ElevatedButton(
              onPressed: () {
                // Navigate to the edit page for this kriteriaBobot
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditKriteriaBobotPage(kriteriaBobot),
                  ),
                ).then((updatedKriteriaBobot) {
                  if (updatedKriteriaBobot != null) {
                    setState(() {
                      // Update the data in kriteriaBobotData with the updatedKriteriaBobot
                      for (var i = 0; i < kriteriaBobotData.length; i++) {
                        if (kriteriaBobotData[i].kriteria.kriteria ==
                            updatedKriteriaBobot.kriteria.kriteria) {
                          kriteriaBobotData[i].bobot =
                              updatedKriteriaBobot.bobot;
                          break;
                        }
                      }
                    });
                  }
                });
              },
              child: Text('Edit'),
            ),
          );
        },
      ),
    );
  }
}
