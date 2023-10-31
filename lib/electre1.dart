import 'dart:math';

import 'package:electre_app/data.dart';
import 'package:electre_app/model.dart';

class ELECTRE1 {
  static get otherAggregatedWeightedNormalizedValue => null;

  static double getNormalizedValue(
      double value, double min, double max, bool isBenefit) {
    if (isBenefit) {
      return (value - min) / (max - min);
    } else {
      return (max - value) / (max - min);
    }
  }

  static double getAggregatedWeightedNormalizedValue(
      Map<String, double> normalizedValues, Map<String, double> weights) {
    double result = 0.0;
    for (var key in normalizedValues.keys) {
      result += normalizedValues[key]! * weights[key]!;
    }
    return result;
  }

  static List<String> electre1(
      List<AlternatifModel> alternatifData,
      Map<String, double> kriteriaWeights, // Pass kriteria weights as a map
      double threshold,
      double concordanceThreshold,
      Map<String, bool> isBenefit) {
    List<String> selectedAlternatives = [];

    for (var alternatif in alternatifData) {
      Map<String, double> normalizedValues = {};
      for (var kriteria in kriteriaWeights.keys) {
        double value = alternatif.nilaiKriteria[kriteria] ?? 0;
        double min =
            kriteriaData.firstWhere((k) => k.kode == kriteria).minValue ?? 0;
        double max =
            kriteriaData.firstWhere((k) => k.kode == kriteria).maxValue ?? 1;
        bool benefit = isBenefit[kriteria] ?? true;
        double normalizedValue = getNormalizedValue(value, min, max, benefit);
        normalizedValues[kriteria] = normalizedValue;
      }

      double aggregatedWeightedNormalizedValue =
          getAggregatedWeightedNormalizedValue(
              normalizedValues, kriteriaWeights);

      if (aggregatedWeightedNormalizedValue >= threshold) {
        bool isConcordant = true;
        for (var otherAlternatif in alternatifData) {
          if (otherAlternatif != alternatif) {
            Map<String, double> otherNormalizedValues = {};
            for (var kriteria in kriteriaWeights.keys) {
              double value = otherAlternatif.nilaiKriteria[kriteria] ?? 0;
              double min =
                  kriteriaData.firstWhere((k) => k.kode == kriteria).minValue ??
                      0;
              double max =
                  kriteriaData.firstWhere((k) => k.kode == kriteria).maxValue ??
                      1;
              double otherAggregatedWeightedNormalizedValue =
                  getNormalizedValue(
                      value, min, max, isBenefit[kriteria] ?? true);
              otherNormalizedValues[kriteria] =
                  otherAggregatedWeightedNormalizedValue;
            }

            if (aggregatedWeightedNormalizedValue <
                    otherAggregatedWeightedNormalizedValue &&
                otherAggregatedWeightedNormalizedValue >=
                    (concordanceThreshold *
                        aggregatedWeightedNormalizedValue)) {
              isConcordant = false;
              break;
            }
          }
        }

        if (isConcordant) {
          selectedAlternatives.add(alternatif.nama);
        }
      }
    }

    return selectedAlternatives;
  }
}
