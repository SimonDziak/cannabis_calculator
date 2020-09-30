import 'package:cannabis_calculator/data/FormulaDao.dart';
import 'package:cannabis_calculator/screens/Formula.dart';
import 'package:cannabis_calculator/utils/AppColors.dart';
import 'package:cannabis_calculator/utils/Constant.dart';
import 'package:cannabis_calculator/utils/JeffIcons.dart';
import 'package:cannabis_calculator/utils/Widgets.dart';
import 'package:flutter/material.dart';

class ServingPage extends StatefulWidget {

  Formula formula;

  ServingPage({Key key, @required this.formula}) : super(key: key);

  @override
  _ServingPageState createState() => _ServingPageState();
}

class _ServingPageState extends State<ServingPage> {


  BuildContext context;

  //Database
  FormulaDao _dao = FormulaDao();


  final _notesTextController = new TextEditingController();
  var _titleTextController = new TextEditingController();
  var _strainTextController = new TextEditingController();

  double cannaProduct = 0;
  double servingSize = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notesTextController.text = widget.formula.notes;
    _titleTextController = new TextEditingController(text: widget.formula.name.toString());
    _strainTextController.text = widget.formula.strain;
    print(widget.formula.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    double oilVal = widget.formula.typeOil.value;
    double thcCannaButter = widget.formula.finalDryWeight * widget.formula.thcComposition * (367.5);


    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topRight,
              stops: [0, 0],
              colors: [
                Colors.white,
                //Color(0xFF43a546),
                Colors.white,
              ],
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //TopBar("Results"),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      TopBar("SERVINGS"),
                      SizedBox(height: 10),
                      getTotalPotency(),
                      SizedBox(height: 10),
                      getSectionHeader("SERVINGS"),
                      getCannaButterAmmount(),
                      getServingSize(),
                      SizedBox(height: 20),
                      getSectionHeader("THC/CBD per serving"),
                      getResults(),
                      getSectionHeader("INFUSION RESULTS"),
                      dataContainer(),
                      SizedBox(height: 10),
                      //buttons(),
                      SizedBox(height: 0)
                    ],
                  )
                ),
              ],
            ),
          ),
        )
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
  Widget getCenterHeader(String title){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0, left: 0),
          child: Text(
            title,
            style: TextStyle(fontFamily: "Bold", color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.0,right: 18.0, bottom: 4),
          child: Divider(
            color: Colors.black,
          ),
        )
      ],
    );

  }

  Widget getTextInfo() {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 75,
      child: Padding(
        padding: EdgeInsets.only(right: width * 1/10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Dried Flower (g): " + (widget.formula.finalDryWeight).toStringAsFixed(1), style: TextStyle(fontFamily: "Medium", fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
                    const Padding(padding: EdgeInsets.only(bottom: 3, left: 5)),
                    Text("Amount of ${widget.formula.typeOil.name.toLowerCase()} (tbsp): ${widget.formula.amountOil}", style: TextStyle(fontFamily: "Medium", fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
                    const Padding(padding: EdgeInsets.only(bottom: 3, left: 5)),
                    Text("THC% " + (widget.formula.thcComposition*100).toStringAsFixed(0) + " | CBD% " + (widget.formula.cbdComposition*100).toStringAsFixed(0), style: TextStyle(fontFamily: "Bold", fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
                    //Text("Final Dry Weight: " + widget.formula.finalDryWeight.toStringAsFixed(1) + " g", style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 15, fontFamily: "Medium")),
                  ],
                )
              )
            ],
        ),
      ),
    );
  }

  String productType() {
    if(widget.formula.typeOil.id == 1) {
      return "CannaButter";
    }
    return "CannaOil";
  }

  Widget getResults() {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: SizedBox(
        height: 75,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${_validateData().toStringAsFixed(2)} mg per serving", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
          ],
        )
      )
    );
  }
  Widget getSideInfo() {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 175,
      child: Padding(
        padding: EdgeInsets.only(right: width * 1/25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    setTitle(),
                    Padding(padding: EdgeInsets.only(left: 20),child: Text("Date " + widget.formula.timeCreated.toString().substring(0,10)))
                    //const Padding(padding: EdgeInsets.only(bottom: 0, left: 0)),
                  ],
                )
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    getStrain(),
                    //Text('Date created: ' + widget.formula.timeCreated.toString().substring(0,10)),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
  Widget getTopInfo() {
    var width = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: SizedBox(
            height: 125,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getSideInfo(),
                AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                      borderRadius: new BorderRadius.circular(3.0),
                      child: Image.asset(
                        widget.formula.typeOil.image,
                        height:  width * 0.25,
                        width: width * 0.25,
                        fit: BoxFit.fill,
                        color: Colors.yellow.withOpacity(
                            0.6),
                        colorBlendMode: BlendMode.multiply,
                      )
                  ),
                ),
              ],
            )
        )
    );
  }
  Widget setTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.black,
          primaryColorDark: Colors.black,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 35.0,
              width: MediaQuery.of(context).size.width * 3/7,
              child: TextField(
                cursorColor: Colors.black,
                controller: _titleTextController,
                autocorrect: true,
                maxLines: 1,
                style: TextStyle(height: 1, color: Colors.black),
                //keyboardType: TextInputType.numberWithOptions(signed: true),
                decoration: InputDecoration(
                  fillColor: Colors.black,
//                    enabledBorder: OutlineInputBorder(
//                      borderSide: BorderSide(
//                        color: Colors.black,
//                        width: 1,
//                      )
//                    ),
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
//                    focusedBorder: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(0.0),
//                      borderSide: BorderSide(
//                        color: Colors.black,
//                        width: 3.0,
//                      )
//                    ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _titleTextController.clear();
                    },
                  ),
                  hintText: "Type here",
                  //labelText: "Name"
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget getNotesButton() {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.black,
          primaryColorDark: Colors.black,
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 150.0,
              width: width*8/9,
              child: TextField(
                controller: _notesTextController,
                autocorrect: true,
                cursorColor: Colors.black,
                cursorWidth: 1,
                showCursor: true,
                maxLines: 5,
                textInputAction: TextInputAction.done,
                style: TextStyle(height: 2, color: Colors.black),
                //keyboardType: TextInputType.numberWithOptions(signed: true),
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 4.0,
                      )
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.only(bottom: 0),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _notesTextController.clear();
                    },
                  ),
                  hintText: "Enter here",
                  hintStyle: TextStyle(color: Colors.black),
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  labelText: "Type any notes you want to add here!",
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget getStrain() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.black,
          primaryColorDark: Colors.black,
        ),
        child: Container(
          height: 40.0,
          width: 175.0,
          child: TextField(
            controller: _strainTextController,
            autocorrect: true,
            cursorColor: Colors.black,
            maxLines: 1,
            textInputAction: TextInputAction.done,
            style: TextStyle(height: 1, color: Colors.black),
            //keyboardType: TextInputType.numberWithOptions(signed: true),
            decoration: InputDecoration(
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1
                  )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 4.0,
                    )
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                hintText: "Enter here",
                hintStyle: TextStyle(color: Colors.black),
                focusColor: Colors.black,
                hoverColor: Colors.black,
                labelText: "Strain Name",
                labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSubmitButton(){
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 20),
      child: Center(
        child: ButtonTheme(
          minWidth: 100.0,
          height: 50.0,
          child: RaisedButton(
            color: appColorPrimaryGold,
            child: Text("Start Over",
                style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Bold")
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0),),
            ),
            onPressed: ()
            {
              _validateData();
              print("Saved name: " + widget.formula.name);
              _dao.insert(widget.formula);
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ),
      ),
    );
  }

  Color getFavoriteButtonColor() {
    if(!widget.formula.isFavorite) {
      return Colors.grey;
    }
    else return Colors.red;
  }

  double _validateData() {
    var num = (widget.formula.thcAmountMg/widget.formula.amountOfCannaProduct)*cannaProduct;
    var finalNum = num/servingSize;
    return finalNum;
  }


  Widget getCannaButterAmmount() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(left: 0.0, top: 5.0),
        child: RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.subtitle1,
              children: [
                TextSpan(
                    text: "Recipe Canna Product (tbsp)", style: TextStyle(fontWeight: FontWeight.bold),
                )
              ]
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.remove),
            color: Colors.black,
            onPressed: () {
              if (cannaProduct > 0) {
                setState(() {
                  cannaProduct -= 1;
                  _validateData();
                });
              } else {
                _validateData();
                // _formData['ticket'] = servingSize;
              }
            },
          ),
          Container(
            width: 35,
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: TextEditingController()..text =  cannaProduct.toStringAsFixed(1),
              onChanged: (num) {
                cannaProduct = double.parse(num);
                _validateData();
              },
            ),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: () {
              if (cannaProduct < widget.formula.amountOfCannaProduct) {
                setState(() {
                  cannaProduct += 1;
                  _validateData();
                });
              } else {
                //_formData['ticket'] = servingSize;
              }
            },
          ),
        ],
      ),
    );
  }
  Widget getServingSize() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(left: 0, top: 5.0),
        child: RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.subtitle1,
              children: [
/*                WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Icon(MyFlutterApp.leaf, size: 18, color: appColorPrimary),
                    )
                ),*/
                TextSpan(
                    text: "Recipe # of Servings", style: TextStyle(fontWeight: FontWeight.bold),
                )
              ]
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.remove),
            color: Colors.black,
            onPressed: () {
              if (servingSize > 0) {
                setState(() {
                  servingSize -= 1;
                  _validateData();
                });
              } else {
               // _formData['ticket'] = servingSize;
              }
            },
          ),
          Container(
            width: 40,
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: TextEditingController()..text =  servingSize.toStringAsFixed(1),
              onChanged: (num) {
                servingSize = double.parse(num);
                _validateData();
              },
            ),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: () {
              if (servingSize < 28.0) {
                setState(() {
                  servingSize += 1.0;
                  _validateData();
                });
              } else {
                //_formData['ticket'] = servingSize;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getTotalPotency() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              border: Border.all(color: appColorPrimary, width: 4)),
          child: Column(
            children: <Widget>[
              getCenterHeader("Total Potency"),
              Text("THC: ${widget.formula.thcAmountMg.toStringAsFixed(2)} mg \nCBD: ${widget.formula.cbdAmountMg.toStringAsFixed(2)} mg",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Bold", fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)),
            ],
          )),
    );
  }

  Widget dataContainer() {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(0),
                child: Text("${productType()} Produced: " + widget.formula.amountOfCannaProduct.toStringAsFixed(1) + " (tbsp)", style: TextStyle(fontFamily: "Bold", fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15))),

//            Container(
//              padding: const EdgeInsets.all(2.0),
//                child: Text("Potency per tablespoon: " + (widget.formula.thcAmountMg/widget.formula.amountOfCannaProduct).toStringAsFixed(3) + " mg", style: TextStyle(fontFamily: "Bold", fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15))),
            Container(
                padding: const EdgeInsets.all(0),
                child: Text("Mg per tbspn: " + mgPerTbspn().toStringAsFixed(3) + " mg",style: TextStyle(fontFamily: "Bold", fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15))),
          ],
        ),
      ),
    );
  }

  //Conversion from THC Tablespoon to Teaspoon
  double mgPerTeaSpoon() {
    var totalTbspn = widget.formula.amountOfCannaProduct;
    var conversionTbspnToTeaspoon = totalTbspn * 3;
    return widget.formula.thcAmountMg/conversionTbspnToTeaspoon;
  }
  double mgPerTbspn() {
    var totalTbspn = widget.formula.amountOfCannaProduct;
    return widget.formula.thcAmountMg/totalTbspn;
  }

}