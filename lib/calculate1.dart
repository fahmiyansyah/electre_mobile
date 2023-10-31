import 'package:flutter/material.dart';

class Electre1 extends StatefulWidget {
  @override
  _ElectreCalculatorState createState() => _ElectreCalculatorState();
}

class _ElectreCalculatorState extends State<Electre1> {
  // Data from Tabel 5: Calon Penerima Beasiswa
  List<String> candidates = ["Mahadi", "Saimon", "Wahdi", "Aditya"];
  List<List<int>> criteriaValues = [
    [5, 3, 3, 3],
    [4, 4, 3, 4],
    [4, 4, 3, 3],
    [2, 4, 3, 3],
  ];

  // Data from Tabel 6: Bobot Pengambilan Siswa
  List<int> criteriaWeights = [5, 2, 4, 2];

  // Result
  List<double> electre1Values = [];
  int selectedStudentIndex = -1;

  @override
  void initState() {
    super.initState();
    calculateElectre1Values();
  }

  void calculateElectre1Values() {
    double maxElectre1 = -1;
    int selectedIndex = -1;
    for (int i = 0; i < candidates.length; i++) {
      double sum = 0;
      for (int j = 0; j < criteriaValues[i].length; j++) {
        sum += criteriaValues[i][j] * criteriaWeights[j];
      }
      electre1Values.add(sum);

      if (sum > maxElectre1) {
        maxElectre1 = sum;
        selectedIndex = i;
      }
    }

    if (selectedIndex != -1) {
      selectedStudentIndex = selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electre 1 Calculator'),
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
              'Hasil Electre 1:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Calon Penerima Beasiswa')),
                DataColumn(label: Text('Nilai Electre 1'))
              ],
              rows: candidates.asMap().entries.map((entry) {
                int index = entry.key;
                String candidate = entry.value;
                double value = electre1Values[index];
                return DataRow(cells: [
                  DataCell(Text(candidate)),
                  DataCell(Text(value.toStringAsFixed(2)))
                ]);
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Siswa dengan Nilai Electre Tertinggi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (selectedStudentIndex != -1)
              Column(
                children: [
                  ListTile(
                    title: Text(candidates[selectedStudentIndex]),
                    subtitle: Text(
                        'Nilai Electre: ${electre1Values[selectedStudentIndex].toStringAsFixed(2)}'),
                  ),
                  Text(
                    'Calon penerima beasiswa terpilih!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
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
