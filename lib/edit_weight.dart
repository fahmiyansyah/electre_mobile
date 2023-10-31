import 'package:electre_app/model.dart';
import 'package:flutter/material.dart';

class EditKriteriaBobotPage extends StatefulWidget {
  final KriteriaBobotModel kriteriaBobot;

  EditKriteriaBobotPage(this.kriteriaBobot);

  @override
  _EditKriteriaBobotPageState createState() => _EditKriteriaBobotPageState();
}

class _EditKriteriaBobotPageState extends State<EditKriteriaBobotPage> {
  late TextEditingController bobotController;

  @override
  void initState() {
    super.initState();
    bobotController =
        TextEditingController(text: widget.kriteriaBobot.bobot.toString());
  }

  @override
  void dispose() {
    bobotController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sukses'),
          content: Text('Perubahan berhasil disimpan!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Send back the updated kriteriaBobot
                double newBobot = double.parse(bobotController.text);
                widget.kriteriaBobot.updateBobot(newBobot);
                Navigator.of(context).pop(); // Close the EditKriteriaBobotPage
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Bobot Kriteria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Kriteria: ${widget.kriteriaBobot.kriteria.kriteria}'),
            TextField(
              controller: bobotController,
              decoration: InputDecoration(labelText: 'Bobot'),
            ),
            ElevatedButton(
              onPressed: () {
                _showSuccessDialog(); // Show the success dialog
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
