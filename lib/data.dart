import 'package:electre_app/model.dart';

List<KriteriaModel> kriteriaData = [
  KriteriaModel("IPK", [
    ScaleModel("> 3.5", 5),
    ScaleModel("3.1 - 3.5", 4),
    ScaleModel("2.6 - 3.0", 3),
    ScaleModel("2.0 - 2.5", 2),
    ScaleModel("< 2.0", 1),
  ]),
  KriteriaModel("Penghasilan Pertahun", [
    ScaleModel("> 36000000", 1),
    ScaleModel("24000001 - 36000000", 2),
    ScaleModel("18000001 - 24000000", 3),
    ScaleModel("< 12000000 - 18000000", 4),
    ScaleModel("<12.000.000", 5),
  ]),
  KriteriaModel("Jumlah Tanggungan", [
    ScaleModel("< 2", 1),
    ScaleModel("2 - 3", 2),
    ScaleModel("4 - 5", 3),
    ScaleModel("6 - 7", 4),
    ScaleModel("> 7", 5),
  ]),
  KriteriaModel("Pekerjaan Orang Tua", [
    ScaleModel("1 - 2", 1),
    ScaleModel("3 - 3", 2),
    ScaleModel("4 - 4", 3),
    ScaleModel("5 - 5", 4),
    ScaleModel("6", 5),
  ]),
];
List<KriteriaBobotModel> kriteriaBobotData = [
  KriteriaBobotModel(
      kriteriaData[0], 5), // Menggunakan KriteriaModel yang sudah ada
  KriteriaBobotModel(kriteriaData[1], 2),
  KriteriaBobotModel(kriteriaData[2], 4),
  KriteriaBobotModel(kriteriaData[3], 2),
];
final List<AlternatifModel> alternatifData = [
  AlternatifModel('Mahadi', {
    'K1': 5.0,
    'K2': 3.0,
    'K3': 3.0,
    'K4': 3.0,
  }),
  AlternatifModel('Saimon', {
    'K1': 4.0,
    'K2': 4.0,
    'K3': 3.0,
    'K4': 4.0,
  }),
  AlternatifModel('Wahdi', {
    'K1': 4.0,
    'K2': 4.0,
    'K3': 3.0,
    'K4': 3.0,
  }),
  AlternatifModel('Aditya', {
    'K1': 2.0,
    'K2': 4.0,
    'K3': 3.0,
    'K4': 3.0,
  }),
];
