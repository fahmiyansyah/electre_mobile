import 'package:flutter/material.dart';

class Electre3 extends StatefulWidget {
  @override
  _ElectreCalculatorState createState() => _ElectreCalculatorState();
}

class _ElectreCalculatorState extends State<Electre3> {
  List<String> candidates = ["Mahadi", "Saimon", "Wahdi", "Aditya"];
  List<List<int>> criteriaValues = [
    [5, 3, 3, 3],
    [4, 4, 3, 4],
    [4, 4, 3, 3],
    [2, 4, 3, 3],
  ];
  List<int> weights = [5, 2, 4, 2];

  Map<String, double> preferenceIndices = {};
  String selectedCandidate = "";

  void calculatePreferenceIndices() {
    for (int i = 0; i < candidates.length; i++) {
      double numerator = 0;
      double denominator = 0;

      for (int j = 0; j < criteriaValues[i].length; j++) {
        numerator += criteriaValues[i][j] * weights[j];
        denominator += criteriaValues[i][j] * criteriaValues[i][j];
      }

      preferenceIndices[candidates[i]] = numerator / denominator;
    }
    // Menentukan penerima beasiswa terpilih
    double maxPreference =
        preferenceIndices.values.reduce((a, b) => a > b ? a : b);
    selectedCandidate = preferenceIndices.entries
        .firstWhere((entry) => entry.value == maxPreference)
        .key;
  }

  @override
  Widget build(BuildContext context) {
    calculatePreferenceIndices();
    // Sort candidates by preference index
    candidates
        .sort((a, b) => preferenceIndices[b]!.compareTo(preferenceIndices[a]!));

    return Scaffold(
      appBar: AppBar(
        title: Text('ELECTRE III Calculator'),
      ),
      body: Column(
        children: [
          DataTable(
            columns: criteriaValues.map((weight) {
              return DataColumn(
                label: Text(
                  'Bobot K${criteriaValues.indexOf(weight) + 1}',
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            rows: candidates.asMap().entries.map((entry) {
              int index = entry.key;
              String candidate = entry.value;
              List<int> values = criteriaValues[index];
              return DataRow(
                cells: values.map((value) {
                  return DataCell(Text(value.toString()));
                }).toList(),
                selected: true,
                onSelectChanged: (bool? selected) {},
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          DataTable(
            columns: [
              DataColumn(label: Text('Calon Penerima Beasiswa')),
              DataColumn(label: Text('Nilai Electre III')),
            ],
            rows: candidates
                .map(
                  (candidate) => DataRow(
                    cells: [
                      DataCell(Text(candidate)),
                      DataCell(Text(preferenceIndices[candidate].toString())),
                    ],
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 20),
          Text(
            'Penerima Beasiswa Terpilih: $selectedCandidate',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
