import 'package:cannabis_calculator/screens/T2Dashboard.dart';
import 'package:cannabis_calculator/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkFunctionForSession().then((status) {
      if (status) {
        _navigateMain();
      }
      else {
        _navigateMain();
      }
    }
    );
  }


  Future<bool> _checkFunctionForSession() async {
    await  Future.delayed(Duration(milliseconds: 5000), () {});

    return true;
  }

  void _navigateMain() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => T2Dashboard()
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
//            Shimmer.fromColors(
//              baseColor: appColorPrimaryGold,
//              highlightColor: appColorPrimary,
//              child: Center(
//                child: Container(
//                  height: 300,
//                  width: 300,
//                    child: Image.asset('images/420chef/thc_logo.png')
//                ),
//              )
//            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 500),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width*1/10, vertical: 50),
                      child: Container(
                          child: Text("developed by dziakstudio",
                              style: TextStyle(
                                fontSize: 13, fontFamily: "Medium",
                              ))),
                    ),
                  ],
                ),
              ),
            ),
            Shimmer.fromColors(
                baseColor: appColorPrimaryGold,
                highlightColor: appColorPrimary,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 500),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width*1/10),
                          child: Container(
                              child: Text("© THC Calculator 2020",
                                  style: TextStyle(
                                    fontSize: 25, fontFamily: "Bold",
                                    shadows: <Shadow>[
                                      Shadow(
                                        blurRadius: 18,
                                        color: Colors.black,
                                        offset: Offset.fromDirection(120, 12)
                                      )
                                    ]
                                  ))),
                        ),
                      ],
                    ),
                  ),
                )
            ),
            Center(
            child: Container(
                height: 250,
                width: 250,
                child: Image.asset('images/420chef/thc_logo.png')
            ))
          ],
        )
      ),
    );
  }
}
