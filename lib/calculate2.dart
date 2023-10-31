import 'package:flutter/material.dart';

class Electre2 extends StatefulWidget {
  @override
  _ElectreCalculatorState createState() => _ElectreCalculatorState();
}

class _ElectreCalculatorState extends State<Electre2> {
  List<String> candidates = ['Mahadi', 'Saimon', 'Wahdi', 'Aditya'];
  List<List<int>> criteriaValues = [
    [5, 3, 3, 3],
    [4, 4, 3, 4],
    [4, 4, 3, 3],
    [2, 4, 3, 3],
  ];
  List<int> criteriaWeights = [5, 2, 4, 2];

  List<String> result = [];
  String bestCandidate =
      ''; // Menyimpan nama siswa dengan nilai ELECTRE tertinggi

  @override
  void initState() {
    super.initState();
    calculateELECTRE2Results();
  }

  void calculateELECTRE2Results() {
    List<double> sums = List.filled(candidates.length, 0);

    for (var i = 0; i < candidates.length; i++) {
      for (var j = 0; j < candidates.length; j++) {
        if (i != j) {
          double sum = 0;
          for (var k = 0; k < criteriaWeights.length; k++) {
            if (criteriaValues[i][k] >= criteriaValues[j][k]) {
              sum += criteriaWeights[k];
            }
          }
          sums[i] += sum;
        }
      }
    }

    var maxSum = sums.reduce((a, b) => a > b ? a : b);

    result = [];
    for (var i = 0; i < candidates.length; i++) {
      var preference = sums[i] / maxSum;
      result.add('${candidates[i]}: ${preference.toStringAsFixed(2)}');
    }

    // Cari siswa dengan nilai ELECTRE tertinggi
    double maxPreference = -1.0;
    int bestCandidateIndex = -1;
    for (int i = 0; i < result.length; i++) {
      double preference = double.parse(result[i].split(': ')[1]);
      if (preference > maxPreference) {
        maxPreference = preference;
        bestCandidateIndex = i;
      }
    }

    if (bestCandidateIndex != -1) {
      bestCandidate = candidates[bestCandidateIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ELECTRE II Calculator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DataTable(
              columns: criteriaWeights.map((weight) {
                return DataColumn(
                  label: Text(
                    'Bobot K$weight',
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
            Text(
              'Hasil Preferensi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Calon Penerima Beasiswa')),
                DataColumn(label: Text('Nilai Electre 2')),
              ],
              rows: candidates.asMap().entries.map((entry) {
                int index = entry.key;
                String candidate = entry.value;
                String electre2Value = result[index];
                return DataRow(cells: [
                  DataCell(Text(candidate)),
                  DataCell(Text(electre2Value)),
                ]);
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Siswa dengan Nilai Electre Tertinggi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (bestCandidate.isNotEmpty)
              Text(
                bestCandidate,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            else
              Text(
                'Tidak ada calon penerima beasiswa yang terpilih.',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
