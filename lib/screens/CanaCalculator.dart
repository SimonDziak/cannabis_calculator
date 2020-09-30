// ignore: avoid_web_libraries_in_flutter
import 'dart:math';

import 'package:cannabis_calculator/data/FormulaDao.dart';
import 'package:cannabis_calculator/models/models.dart';
import 'package:cannabis_calculator/screens/Formula.dart';
import 'package:cannabis_calculator/screens/FormulaResults.dart';
import 'package:cannabis_calculator/utils/AppColors.dart';
import 'package:cannabis_calculator/utils/CustomSlider.dart';
import 'package:cannabis_calculator/utils/DbDataGenerator.dart';
import 'package:cannabis_calculator/utils/JeffIcons.dart';
import 'package:cannabis_calculator/utils/flutter_done_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class CanaCalculator extends StatefulWidget {
  static var tag = "/CanaCalculator";
  //var title = "Infused Cannabis Calculator";

  CanaCalculator();


  @override
  CanaCalculatorState createState() => CanaCalculatorState();
}

List<DbOilType> oilTypes = getOilTypes();

class CanaCalculatorState extends State<CanaCalculator> {

  //reset radiobutton
  //call oilTypes = getOilTypes(); in widget build
  FormulaDao _dao = FormulaDao();

  //Constants
  Color mRegistrationBlack = Colors.black;

  SliderWidget thcPercentValue = new SliderWidget();
  SliderWidget cbdPercentValue = new SliderWidget();
  GetOilTypes getOilTypesWidget = new GetOilTypes(oilTypes);
  BuildContext context;

  String finalOilType = "";
  double finalWeightValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _numberTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color mRegistrationBlack = Colors.black;

    //Formula formula = new Formula(0.0, 0.0, 0.0, 0, null, DateTime.now());

    this.context = context;
    double a = thcPercentValue.value;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Column(
          children: <Widget>[
            getSectionHeader("STARTING COMPOSITION"),
            getTHCPerc(),
            getCBDPerc(),
            getCannabisWeightCounter(),
            SizedBox(height: 35),
            getSectionHeader("INFUSION TYPE"),
            getOilTypesWidget,
            getButterMeasureListTile(),
            getSectionDivider(),
            getSubmitButton(),
            getConversionChart(),
          ]
      ),
    );
  }

  Map<String, dynamic> _formData = <String, dynamic>{
    'name': '???',
    'ticket': 0,
    'substance': 0,
    'food': false,
  };

  // Measurement Types for Butter
  List<MeasurementType> measurementTypes = <MeasurementType>[
    const MeasurementType("Tablespoons"),
    const MeasurementType("Cup"),
    const MeasurementType("Ounce"),
  ];

  MeasurementType selectedMeasurementType;

  final _numberTextController = TextEditingController();
  bool _validateName = false;

  void _resetFields() {
    _numberTextController.text = '';
    Map<String, dynamic> _formData = <String, dynamic>{
      'name': '???',
      'ticket': 0,
      'substance': 0,
      'food': false,
    };

    setState(() {
      finalWeightValue = 0.0;
      _validateName = false;
    });
  }

  void _showDialog(String title, String content) {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text("ALERT_OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _handleGenderChange(int value) =>
      setState(() => _formData['substance'] = value);

  void _handleFoodOption(bool value) =>
      setState(() => _formData['food'] = value);

  ListTile getTHCPerc() {
    return new ListTile(
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(6,0,10,0),
        child: RichText(
          text: TextSpan(
          style: Theme.of(context).textTheme.subtitle1,
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 5, 0),
                  child: Icon(MyFlutterApp.flask, size: 18, color: appColorPrimary),
                )
              ),
              TextSpan(
                text: "THC%"
              )
            ]
        ),
        ),
      ),
      title: Column(
        children: <Widget>[
          thcPercentValue,
        ],
      ),
      dense: true,
    );
  }
  ListTile getCBDPerc() {
    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0.0, 8, 0),
          child: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.subtitle1,
                children: [
                  WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 5, 0),
                        child: Icon(MyFlutterApp.flask, size: 18, color: appColorPrimary),
                      )
                  ),
                  TextSpan(
                      text: "CBD%",
                  ),
                ]
            ),
          ),
        ),
        title: new Column(
          children: <Widget>[
            cbdPercentValue,
          ],
        ),
      dense: true,
    );
  }

  ListTile getButterMeasureListTile() {
    //selectedMeasurementType = measurementTypes[0];

    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DropdownButton<MeasurementType>(
          hint: Text("Select measurement"),
          value: selectedMeasurementType,
          icon: Icon(Icons.arrow_downward),
          iconSize: 20,
          elevation: 24,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: appColorPrimaryGold,
          ),
          onChanged: (s) {
            setState(() {
              selectedMeasurementType = s;
            });
          },
          items: measurementTypes.map((MeasurementType selected) {
            return DropdownMenuItem<MeasurementType>(
              value: selected,
              child:
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                    ),
                    Text(
                        selected.name,
                        style: TextStyle(color: Colors.black),
                      ),
                  ],
                ),
            );
          }).toList(),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 0, right: 8.0),
        child: Theme(
          data: ThemeData(
            primaryColor: mRegistrationBlack,
            primaryColorDark: mRegistrationBlack,
          ),
          child: Container(
            height: 40.0,
            width: 200.0,
            child: TextField(
              //style: Theme.of(context).textTheme.subtitle2,
              controller: _numberTextController,
              autocorrect: true,
              //keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  fillColor: mRegistrationBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: mRegistrationBlack,
                    ),
                    onPressed: () {
                      _numberTextController.clear();
                    },
                  ),
                  hintText: "Ex: 4",
                  labelText: "Amount"),
            ),
          ),
        ),
      ),
    );
  }
  // Final Dry Weight
  Widget getCannabisWeightCounter() {
    var width = MediaQuery.of(context).size.width;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      leading: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 5.0),
        child: RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.subtitle1,
              children: [
                WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 15, 0),
                      child: Icon(MyFlutterApp.balance_scale_left, size: 18, color: appColorPrimary),
                    )
                ),
                TextSpan(
                    text: "Final Dry Weight (g)"
                )
              ]
          ),
        ),
      ),
      title: Row(
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 0),
            icon: Icon(Icons.remove),
            color: mRegistrationBlack,
            onPressed: () {
              if (finalWeightValue > 0.1) {
                setState(() {
                  finalWeightValue -= 0.1;
                });
              } else {
                _formData['ticket'] = finalWeightValue;
              }
            },
          ),
          Container(
            width: 35,
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: TextEditingController()..text =  finalWeightValue.toStringAsFixed(1),
              onChanged: (num) {
                finalWeightValue = double.parse(num);
                },
            ),
          ),
          IconButton(
            padding: EdgeInsets.only(left: 0),
            icon: Icon(Icons.add),
            color: mRegistrationBlack,
            onPressed: () {
              if (finalWeightValue < 28) {
                setState(() {
                  finalWeightValue += 0.1;
                  //_validateData();
                });
              } else {
                _formData['ticket'] = finalWeightValue;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getFoodOption(){
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: Checkbox(
          activeColor: mRegistrationBlack,
          onChanged: _handleFoodOption,
          value: _formData['food'] as bool,
        ),
        title: InkWell(
          onTap: (){
            setState(() {
              _formData['food'] = !_formData['food'];
            });
          },
          child: Text(
            "Butter used (tbps)",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ),
    );
  }

  Widget getSectionHeader(String title){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0, left: 18),
        child: Text(
          title,
          style: TextStyle(fontFamily: "Bold", color: Colors.grey[600]),
          textAlign: TextAlign.left,
        ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.0,right: 18.0, bottom: 10),
          child: Divider(
            color: Colors.black,
          ),
        )
      ],
    );

  }
  Widget getSectionDivider(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0,right: 18.0, bottom: 0, top: 2),
          child: Divider(
            color: Colors.black.withOpacity(0.5),
          ),
        )
      ],
    );

  }
  Widget backIcon() {
    /*back icon*/
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget getSubmitButton(){
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: ButtonTheme(
              minWidth: 120.0,
              height: 33.0,
              child: RaisedButton(
              color: appColorPrimaryGold,
                child: Text("Calculate",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Regular")
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0),),
                ),
                onPressed: ()
                {
                  _validateData();
                },
              ),
        ),
      ),
    );
  }

  void calculate(Formula formula) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => FormulaResults(formula: formula)));
  }

  void _validateData() {
    //Todo validate all data is selected and greater then one.
    //Multiply the value by 1/2 to fix bug with the slider.
    double thcPerc = double.parse((thcPercentValue.value*(1/2)).toStringAsFixed(2));
    double cbdPerc = double.parse((cbdPercentValue.value*(1/2)).toStringAsFixed(2));

    if(_numberTextController.text.isEmpty || selectedMeasurementType.name == null || finalWeightValue == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Calculation Error"),
              content: Text("Please review your input."),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //_resetFields();
                  },
                )
              ],
            );
          }
      );
    }
    else {
      int amountOil = int.parse(_numberTextController.text);
      final formula = new Formula(
          thcComposition: thcPerc,
          cbdComposition: cbdPerc,
          finalDryWeight: finalWeightValue,
          amountOil: amountOil,
          typeOil: getOilTypesWidget.selectedOilType,
          selectedMeasure: selectedMeasurementType.name,
          timeCreated: DateTime.now().toString());
      formula.calculateConcentration();
      formula.isFavorite = false;
      calculate(formula);

//      log("Selected Oil Type: " + getOilTypesWidget.selectedOilTypeName);
//      log("Final Weight Value " + finalWeightValue.toStringAsFixed(1));
//      log("Selected Measurement type: " + selectedMeasurementType.name);
//      log("Amount typed in: " + _numberTextController.text);

    }

    double cbdPercValue = cbdPercentValue.value;
    //log("Thc Perc " + thcPercValue.toStringAsFixed(2));
  }

  void _submitForm() {
    _formData['name'] = _numberTextController.text;
    setState(() {
      _numberTextController.text.isEmpty
          ? _validateName = true
          : _validateName = false;
    });

    if (!_validateName) {
      final bool success = true;

      if (success) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("TITLE_SUBMISSION_SUCCESS"),
                content: Text("MESSAGE_SUBMISSION_SUCCESS"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("ALERT_OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _resetFields();
                    },
                  )
                ],
              );
            }
        );
      } else {
        _showDialog("TITLE_ERROR", "MESSAGE_ERROR");
      }
    } else {
      _showDialog("TITLE_VALIDATION", "MESSAGE_VALIDATION");
    }
  }

  Widget getConversionChart() {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          border: TableBorder.all(),
          children: [
            TableRow( children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "Butter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20, fontFamily: "Bold"),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "Grams",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,fontFamily: "Bold"),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "Tbspn",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,fontFamily: "Bold"),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "Oil",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,fontFamily: "Bold"),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "Grams",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,fontFamily: "Bold"),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "Tbspn",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,fontFamily: "Bold"),
                  ),
                ),
              ),
            ]),
            TableRow( children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1 Stick",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "113.4",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "8",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1 Cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "219.55",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "16",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
            ]),
            TableRow( children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1 cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "226.8",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "16",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "3/4 cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "164.67",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "12",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
            ]),
            TableRow( children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "3/4 cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "170.1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "12",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1/2 cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "109.78",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "8",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
            ]),
            TableRow( children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1/2 cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "113.4",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "8",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1/4 cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "54.89",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "4",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
            ]),
            TableRow( children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1/4 cup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "56.7",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "4",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1 tbspn",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "13.72",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
            ]),
            TableRow( children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1 tbspn",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "14.18",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "1 fluid ounce",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "24.44",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  margin: EdgeInsets.all(2),
                  color: appColorPrimary,
                  width: 80.0,
                  height: 30.0,
                  child: Text(
                    "2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    ]);
  }


}

// !!!
// Responsibe for Oil Types
class GetOilTypes extends StatefulWidget {

  List<DbOilType> list;
  String selectedOilTypeName;
  DbOilType selectedOilType;
  GetOilTypes(this.list);

  @override
  _GetOilTypesState createState() => _GetOilTypesState();
}

class _GetOilTypesState extends State<GetOilTypes> {

  var selectedValue;
  @override
  void initState() {
    // Resets the button color everytime the widget is initiated
    for(int i=0; i < widget.list.length; i++) {
      // Each DbTypeOil has isPressed value
      widget.list[i].value = 0.0;
    }

    super.initState();
    //selectedValue=widget.list.first;
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
        SizedBox(
        height: width * 0.25,
        child:  ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return Container(
              width: width * 0.27,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 0, left: 0, top: 0),
                    child: ClipRRect(
                        borderRadius: new BorderRadius.circular(3.0),
                        child: Image.asset(
                          widget.list[index].image,
                          fit: BoxFit.fill,
                          height: width * 0.25,
                          width: width * 0.25,
                          color: Colors.yellow.withOpacity(
                              widget.list[index].value),
                          colorBlendMode: BlendMode.multiply,
                        )
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Radio(
                            value: widget.list[index],hoverColor: Colors.white.withOpacity(0),activeColor: Colors.white.withOpacity(0),focusColor: Colors.white.withOpacity(1), groupValue: selectedValue,
                          onChanged: (s) {
                            selectedValue = s;
                            setState(() {
                              for(int i=0; i < widget.list.length; i++) {
                                // Each DbTypeOil has isPressed value
                                  widget.list[i].value = 0.0;
                              }
                              widget.selectedOilTypeName = widget.list[index].name;
                              widget.selectedOilType = widget.list[index];
                              selectedValue.value = 0.6;
                            });
                        }),
                      ),
                    ),
                  ),
                ],
              )
            );
          },
          itemCount: widget.list.length,
        ),
        ),
    ],
    ),
    );
  }
}


// !!!


class FormAppButton extends RaisedButton {

  final String text;
  final Function action;
  final Color color;

  FormAppButton({@required this.text, @required this.action, @required this.color});

  ButtonTheme getButton(BuildContext context) {
    return ButtonTheme(
      minWidth: 120.0,
      height: 33.0,
      child: RaisedButton(
        color: appColorPrimaryGold,
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 18, fontFamily: "Regular")
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        onPressed: () {
          action();
        },
      ),
    );
  }
}
