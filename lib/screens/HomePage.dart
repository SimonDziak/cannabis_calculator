import 'package:cannabis_calculator/data/FormulaDao.dart';
import 'package:cannabis_calculator/screens/DbFormulaResults.dart';
import 'package:cannabis_calculator/screens/Formula.dart';
import 'package:cannabis_calculator/screens/FormulaResults.dart';
import 'package:cannabis_calculator/utils/AppColors.dart';
import 'package:cannabis_calculator/utils/JeffIcons.dart';
import 'package:cannabis_calculator/utils/T2Slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FormulaDao _dao = new FormulaDao();
  var items;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = _dao.getAll();
    setState(() {
      items = _dao.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        T2SliderWidget(),
        SizedBox(height: 0),
        getDeleteButton(),
        SizedBox(height: 10),
        getSectionHeader("RECENT CALCULATIONS"),
        recentCalculations(),
      ],
    );
  }

  // Todo implement recent calculations
  Widget recentCalculations() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: MediaQuery.of(context).size.height * 1/2,
        width: width * 0.90,
        child: FutureBuilder(
          future: items,
          //initialData: _calculation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                !snapshot.hasData) {
              return Text('Loading data...');
            }
            else if(snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DbFormulaResults(formula: snapshot.data[index])));
                    },
                    child: Card(
                      elevation: 7,
                      child: ListTile(
                        title: Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(snapshot.data[index].name.toString()),
                        ),
                        subtitle: Text("Infused ${snapshot.data[index].typeOil.name}"),
                        //leading: IconButton(icon: Icon(MyFlutterApp.window_close), iconSize: 18, alignment: Alignment(-2.5, 0),),
                        //contentPadding: EdgeInsets.only(left: 20, right: 20),
                        trailing: Text("THC (mg): ${snapshot.data[index].thcAmountMg.toStringAsFixed(2)} \n CBD (mg): ${snapshot.data[index].cbdAmountMg.toStringAsFixed(2)} ",textAlign: TextAlign.right,),
                      )
                    ),
                  );
                }
              );
            }
            else if(snapshot.hasError) { return Text('Error: ${snapshot.error}');}
            else if(snapshot.hasData) {return Text("has data");}
            else {
              return Text("No data yet... probably loading");
            }
          },
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
          padding: EdgeInsets.only(left: 18.0,right: 18.0, bottom: 0),
          child: Divider(
            color: Colors.black,
          ),
        )
      ],
    );

  }

  Widget getDeleteButton(){
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 0),
      child: ButtonTheme(
        minWidth: 80.0,
        height: 35.0,
        child: RaisedButton(
          color: appColorPrimaryGold,
          child: Text("Clear Recent Calculations"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.0),),
          ),
          onPressed: ()
          {
            setState(() {
              _dao.deleteAll();
              items = _dao.getAll();
            });
            //_validateData();
          },
        ),
      ),
    );
  }


}
