import 'package:flutter/material.dart';

class T2Favourite {
  var name = "";
  var duration = "";
  var image = "";
}

class T2Slider {
  var title = "";
  var subTitle = "";
  var image = "";
  var url = "";
}

class T2DrawerItem {
  var title = "";
  var image;

  var isSelected = false;
}

class T2ListModel {
  var name = "";
  var duration = "";
  var type = "";
  var description = "";
  var icon = "";
}

class MeasurementType {
  const MeasurementType(this.name);
  final String name;
}

// DbOilType is used for CanaCalculator to display different oil type infusions
class DbOilType {
  // ID of each oil type
  var id;
  // Name of each oil type
  var name = '';
  // Value is responsible for the highlight value in the calculator
  var value = 0.0;
  // isPressed is responsible for functionality of the highlight option in the calculator
  bool isPressed = false;
  // Image is responsible for the image displayed in the calculator
  var image = "";

  // Not used yet, can use this to call custom functionality like reset all the values etc.
  VoidCallback onCallBack;

  double convertToGrams(String measurementType, int amount) {
    double conversionRatio;
    switch(measurementType) {
      case "Tablespoons": {
        conversionRatio = (this.id == 1) ? 14.8 : 13.72;
      }
      break;
      case "Cup": {
        conversionRatio = (this.id == 1) ? 226.8 : 219.55;
      }
      break;
      case "Ounce": {
        conversionRatio = (this.id == 1) ? 28.35 : 27.44;
      }
      break;
    }
    return amount * conversionRatio;
  }

  void resetValues() {
    isPressed = false;
    value = 0.0;
  }
}