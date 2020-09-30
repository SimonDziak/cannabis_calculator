import 'package:cannabis_calculator/models/models.dart';
import 'package:cannabis_calculator/utils/DbDataGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class Formula {

  static int idNum = 0;
  int id;
  //Final Values
  double thcComposition;
  double cbdComposition;
  double finalDryWeight;
  int amountOil;
  DbOilType typeOil;
  String timeCreated;
  //TODO might want to change this to datatype MeasurementType
  String selectedMeasure;

  double thcConcentrationPercentage;
  double cbdConcentrationPercentage;
  double amountOfCannaProduct;
  double thcAmountMg;
  double cbdAmountMg;


  String name = "Calculation 00x";
  String notes;
  String strain;


  bool isFavorite = false;

  Formula(
      {this.thcComposition,
      this.cbdComposition,
      this.finalDryWeight,
      this.amountOil,
      this.typeOil,
      this.selectedMeasure,
      this.timeCreated,
      this.thcAmountMg,
        this.cbdAmountMg,
        this.amountOfCannaProduct,
        this.thcConcentrationPercentage,
        this.cbdConcentrationPercentage,
      this.name,
      this.notes,
        this.strain,
        this.isFavorite,
      });

  Map<String, dynamic> toMap() {
    return {
      'thcComposition': thcComposition,
      'cbdComposition': cbdComposition,
      'finalDryWeight': finalDryWeight,
      'amountOil': amountOil,
      'typeOil': typeOil.id,
      'selectedMeasure': selectedMeasure,
      'timeCreated': timeCreated.toString(),
      'thcAmountMg': thcAmountMg,
      'cbdAmountMg': cbdAmountMg,
      'amountOfCannaProduct': amountOfCannaProduct,
      'thcConcentrationPercentage': thcConcentrationPercentage,
      'cbdConcentrationPercentage': cbdConcentrationPercentage,
      'name': name,
      'notes': notes,
      'strain': strain,
      'isFavorite': isFavorite,
    };
  }

  static Formula fromMap(Map<String, dynamic> map) {
    DbOilType selectedOil;
    for (DbOilType oil in getOilTypes()) {
      if (map['typeOil'] == oil.id) {
        selectedOil = oil;
      }
    }
    return Formula(
      thcComposition: map['thcComposition'],
      cbdComposition: map['cbdComposition'],
      finalDryWeight: map['finalDryWeight'],
      amountOil: map['amountOil'],
      typeOil: selectedOil,
      selectedMeasure: map['selectedMeasure'],
      timeCreated: map['timeCreated'],
      thcAmountMg: map['thcAmountMg'],
      cbdAmountMg: map['cbdAmountMg'],
      amountOfCannaProduct: map['amountOfCannaProduct'],
      thcConcentrationPercentage: map['thcConcentrationPercentage'],
      cbdConcentrationPercentage: map['cbdConcentrationPercentage'],
      name: map['name'],
      notes: map['notes'],
      strain: map['strain'],
      isFavorite: map['isFavorite']
    );
  }

  calculateConcentration() {
    //idNum++;
    name = "Calculation 00x";
    double oilInGrams = typeOil.convertToGrams(selectedMeasure, amountOil);
    double oilLossFactor = (typeOil.id == 1) ? .75 : .8;
    amountOfCannaProduct = oilLossFactor*oilInGrams;
    thcConcentrationPercentage = (thcComposition*100*finalDryWeight*.5)/((amountOfCannaProduct) + finalDryWeight);
    cbdConcentrationPercentage = (cbdComposition*100*finalDryWeight*.5)/((amountOfCannaProduct) + finalDryWeight);
    double weedLossFactor = (typeOil.id == 1) ? .7 : .9;
    thcAmountMg = ((thcComposition*100*7*finalDryWeight)/oilInGrams)*amountOfCannaProduct*weedLossFactor;
    cbdAmountMg = ((cbdComposition*100*7*finalDryWeight)/oilInGrams)*amountOfCannaProduct*weedLossFactor;
    amountOfCannaProduct /= 14.5; //convert to grams
  }


}