import 'dart:math';

import 'package:cannabis_calculator/screens/Formula.dart';
import 'package:cannabis_calculator/screens/FormulaResults.dart';
import 'package:cannabis_calculator/utils/AppColors.dart';
import 'package:cannabis_calculator/utils/JeffIcons.dart';
import 'package:cannabis_calculator/utils/Widgets.dart';
import 'package:flutter/material.dart';

class CookingCalculator extends StatefulWidget {
  static var tag = "/CookingCalculator";
  Formula formula;

  CookingCalculator({Key key, @required this.formula}) : super(key: key);

  @override
  CookingCalculatorState createState() => CookingCalculatorState();
}

class CookingCalculatorState extends State<CookingCalculator> {

  //Formula formula;
  BuildContext context;
  int numberOfServings = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this.context = context;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 90),
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
//                IconButton(
//                  icon: Icon(Icons.arrow_back),
//                  color: Colors.black,
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          child: new ListTile(
                            leading: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.title,
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                        child: Icon(MyFlutterApp.book_medical, size: 24, color: appColorPrimary),
                                    ),
                                ),
                                    TextSpan(text: "Amount of CannaOil:", style: TextStyle(fontSize: 21,),),
                                  ])),
                            title: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 5),
                                  child: Text(widget.formula.finalDryWeight.toStringAsFixed(2), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
//                        GestureDetector(
//                          child: text("Text two",
//                              textColor: t2TextColorPrimary,
//                              fontSize: textSizeNormal,
//                              fontFamily: fontBold),
//                          onTap: () {
//                            //Navigator.push(context,
//                            //    MaterialPageRoute(builder: (context) => T2Dashboard()));
//                          },
//                        ),
                        getNumberOfServings(),
                        getSubmitButton(),
                        //Todo add THC/CBD in cannabutter
                        //Todo add plus minus widget for amount of servings
                        //Todo add heading for Cooking and Baking with CannaButter
                        //Todo INPUT Recipe CannaButter Amount (tbsp):
                        //Todo INPUT Recipe Number of Servings:
                        //Todo OUTPUT THC/CBD per serving
                        //Todo INPUT for Notes section of formula
                        //Todo BUTTON to save formula to database
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          TopBar("Cooking Calculator"),
          //text(formula.notes),
          //text((formula.startingThcPerc).toString()),
        ],
      )
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
            child: Text("See Results",
                style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Regular")
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0),),
            ),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormulaResults(formula: widget.formula)));
              log(widget.formula.cbdConcentrationPercentage);
              widget.formula.calculateConcentration();
              log(widget.formula.thcConcentrationPercentage);
              //_validateData();
            },
          ),
        ),
      ),
    );
  }

  ListTile getNumberOfServings() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(left: 2.0, top: 0),
        child: RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.title,
              children: [
                WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(MyFlutterApp.cookie_bite, size: 24, color: appColorPrimary),
                    )
                ),
                TextSpan(
                    text: "# of Servings", style: TextStyle(fontSize: 21)
                )
              ]
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(15),
            icon: Icon(Icons.remove),
            color: Colors.black,
            onPressed: () {
              if (numberOfServings > 0) {
                setState(() {
                  numberOfServings -= 1;
                });
              } else {
                //_formData['ticket'] = finalWeightValue;
              }
            },
          ),
          Text(
            numberOfServings.toString(),
            style: Theme.of(context).textTheme.title,
          ),
          IconButton(
            padding: EdgeInsets.all(15),
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: () {
              if (numberOfServings < 28) {
                setState(() {
                  numberOfServings += 1;
                  log(4);
                  //_validateData();
                });
              } else {
                //_formData['ticket'] = finalWeightValue;
              }
            },
          ),
        ],
      ),
    );
  }


}