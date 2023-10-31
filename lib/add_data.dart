import 'package:electre_app/edit_weight.dart';
import 'package:flutter/material.dart';
import 'package:electre_app/data.dart';
import 'package:electre_app/model.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  TextEditingController criteriaController = TextEditingController();
  TextEditingController scaleController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data added successfully!'),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: criteriaController,
              decoration: InputDecoration(labelText: 'Criteria'),
            ),
            TextField(
              controller: scaleController,
              decoration: InputDecoration(labelText: 'Scale'),
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Scale Weight'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate and add data to the kriteriaData list
                if (criteriaController.text.isNotEmpty &&
                    scaleController.text.isNotEmpty &&
                    weightController.text.isNotEmpty) {
                  final newScale = ScaleModel(
                    scaleController.text,
                    double.parse(weightController.text),
                  );
                  KriteriaModel? existingKriteria;
                  try {
                    existingKriteria = kriteriaData.firstWhere(
                      (kriteria) =>
                          kriteria.kriteria == criteriaController.text,
                    );
                  } catch (e) {
                    // Handle exceptions if needed (e.g., Element not found)
                  }

                  if (existingKriteria != null) {
                    existingKriteria.scales.add(newScale);
                  } else {
                    final newKriteria =
                        KriteriaModel(criteriaController.text, [newScale]);
                    kriteriaData.add(newKriteria);
                  }

                  // Show a success message
                  showSuccessSnackBar();

                  // Send back the updated kriteriaData to ElectreWeight
                  Navigator.of(context).pop(kriteriaData);
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
