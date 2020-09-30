import 'package:cannabis_calculator/models/models.dart';
import 'package:cannabis_calculator/utils/Colors.dart';
import 'package:cannabis_calculator/utils/Constant.dart';
import 'package:cannabis_calculator/utils/Widgets.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'T2DataGenerator.dart';
import 'T2SliderWidget.dart';

class T2SliderWidget extends StatefulWidget {
  static String tag = '/T2Slider';

  @override
  T2SliderWidgetState createState() => T2SliderWidgetState();
}

class T2SliderWidgetState extends State<T2SliderWidget> {
  var currentIndexPage = 0;
  List<T2Slider> mSliderList;

  @override
  void initState() {
    super.initState();
    mSliderList = getSliders();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final Size cardSize = Size(width, width / 1.8);
    return Column(
      children: <Widget>[
        T2CarouselSlider(
          viewportFraction: 0.9,
          height: cardSize.height,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          items: mSliderList.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    _launchURL(slider.url);
                    print("Pressed");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: cardSize.height,
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: new BorderRadius.circular(4.0),
                          child: Image.asset(
                            slider.image,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: cardSize.height,
                            colorBlendMode: BlendMode.darken,
                            color: Colors.black26,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: width*0.2),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                text(slider.title, textColor: t2_white, fontSize: textSizeNormal, fontFamily: fontSemibold, isCentered: true),
                                SizedBox(height: 20),
                                text(slider.subTitle, textColor: t2_white, fontSize: textSizeMedium, maxLine: 2, isCentered: true),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          onPageChanged: (index) {
            setState(() {
              currentIndexPage = index;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        DotsIndicator(
            dotsCount: mSliderList.length,
            position: currentIndexPage,
            decorator: DotsDecorator(
              size: const Size.square(5.0),
              activeSize: const Size.square(8.0),
              color: Colors.black,
              activeColor: Colors.black,
            ))
      ],
    );
  }

  _launchURL(var urlIn) async {
    var url = urlIn;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
