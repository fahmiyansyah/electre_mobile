import 'package:electre_app/data.dart';
import 'package:electre_app/model.dart';
import 'package:flutter/material.dart';

class AddAlternatifPage extends StatefulWidget {
  @override
  _AlternatifPageState createState() => _AlternatifPageState();
}

class _AlternatifPageState extends State<AddAlternatifPage> {
  TextEditingController alternatifController = TextEditingController();
  Map<String, double> nilaiKriteria = {};

  // Initialize dropdown values
  Map<String, String> selectedScales = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Alternatif'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: alternatifController,
              decoration: InputDecoration(labelText: 'Nama Alternatif'),
            ),
            // Dropdown for each criterion
            for (var kriteria in kriteriaData)
              Column(
                children: [
                  Text(_getKriteriaLabel(
                      kriteria.kriteria)), // Label sesuai yang diinginkan
                  DropdownButton<String>(
                    value: selectedScales[kriteria.kriteria],
                    items: kriteria.scales
                        .map((scale) => DropdownMenuItem<String>(
                              value: scale.value,
                              child: Text(scale.value),
                            ))
                        .toList(),
                    onChanged: (selectedValue) {
                      setState(() {
                        selectedScales[kriteria.kriteria] = selectedValue!;
                        if (selectedValue != null) {
                          nilaiKriteria[kriteria.kriteria] = kriteria.scales
                              .firstWhere(
                                  (scale) => scale.value == selectedValue)
                              .bobot;
                        } else {
                          nilaiKriteria.remove(kriteria.kriteria);
                        }
                      });
                    },
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                if (alternatifController.text.isNotEmpty &&
                    nilaiKriteria.isNotEmpty) {
                  final newAlternatif =
                      AlternatifModel(alternatifController.text, nilaiKriteria);
                  // Add newAlternatif to your data list (e.g., alternatifData)
                  alternatifData.add(newAlternatif);

                  // Show a success message using ScaffoldMessenger
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Alternatif berhasil ditambahkan!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Navigate back to the previous page
                  Navigator.of(context).pop();
                }
              },
              child: Text('Tambah Alternatif'),
            ),
          ],
        ),
      ),
    );
  }

  String _getKriteriaLabel(String kriteria) {
    // Ganti sesuai kebutuhan, misalnya ubah label menjadi K1, K2, K3, K4
    switch (kriteria) {
      case "IPK":
        return "K1: Nilai IPK";
      case "Penghasilan Pertahun":
        return "K2: Penghasilan Per Tahun";
      case "Jumlah Tanggungan":
        return "K3: Jumlah Tanggungan";
      case "Pekerjaan Orang Tua":
        return "K4: Pekerjaan Orang Tua";
      default:
        return kriteria;
    }
  }
}
