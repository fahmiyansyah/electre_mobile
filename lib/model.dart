class KriteriaModel {
  final String kriteria;
  final List<ScaleModel> scales;

  KriteriaModel(this.kriteria, this.scales);

  get kode => null;

  double? get maxValue => null;

  double? get minValue => null;
}

class ScaleModel {
  final String value;
  final double bobot;

  ScaleModel(this.value, this.bobot);
}

class KriteriaBobotModel {
  final KriteriaModel kriteria;
  double bobot;

  KriteriaBobotModel(this.kriteria, this.bobot);

  void updateBobot(double newBobot) {
    bobot = newBobot;
  }
}

class AlternatifModel {
  final String nama;
  final Map<String, double> nilaiKriteria;

  AlternatifModel(this.nama, this.nilaiKriteria);
}

