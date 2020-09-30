import 'package:cannabis_calculator/models/models.dart';
import 'package:cannabis_calculator/screens/CanaCalculator.dart';
import 'package:cannabis_calculator/screens/FavoritesPage.dart';
import 'package:cannabis_calculator/screens/HomePage.dart';
import 'package:cannabis_calculator/utils/AppColors.dart';
import 'package:cannabis_calculator/utils/Colors.dart';
import 'package:cannabis_calculator/utils/Constant.dart';
import 'package:cannabis_calculator/utils/Images.dart';
import 'package:cannabis_calculator/utils/JeffIcons.dart';
import 'package:cannabis_calculator/utils/Strings.dart';
import 'package:cannabis_calculator/utils/T2BubbleBotoomBar.dart';
import 'package:cannabis_calculator/utils/T2DataGenerator.dart';
import 'package:cannabis_calculator/utils/Widgets.dart';
import 'package:cannabis_calculator/utils/flutter_done_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:url_launcher/url_launcher.dart';

class T2Dashboard extends StatefulWidget {
  static var tag = "/T2Dashboard";

  @override
  T2DashboardState createState() => T2DashboardState();
}

class T2DashboardState extends State<T2Dashboard> {
  bool passwordVisible = false;
  bool isRemember = false;
  var currentIndexPage = 1;
  List<T2Favourite> mFavouriteList;
  List<T2Slider> mSliderList;

  // Todo create working navigation bar. Home page, Calculator, Favorites (saved formulas)
  var currentIndex = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    mFavouriteList = getFavourites();
    mSliderList = getSliders();
    KeyboardVisibilityNotification().addNewListener(
      onShow: () {
        KeyboardOverlay.showOverlay(context);
      },
      onHide: () {
        KeyboardOverlay.removeOverlay();
      },
    );
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void changeSlider(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }
  var canaCalculator = new CanaCalculator();
  var homePage = new HomePage();
  var favoritesPage = new FavoritesPage();

  @override
  Widget build(BuildContext context) {

    final List<Object> _children = [
      homePage,
      canaCalculator,
      favoritesPage,
      //Home Page,
      //Favorites Page,
    ];
    final List<String> _titles = [
      "Home",
      "THC/CBD Calculator",
      "Favorite Calculations"
    ];

    _launchURL(var urlIn) async {
      var url = urlIn;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    var width = MediaQuery.of(context).size.width;

    width = width - 50;
    final Size cardSize = Size(width, width / 1.5);


    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 90),
              //physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16),
                  _children[currentIndex],
                ],
              ),
            ),
            TopBarCenter(_titles[currentIndex])
          ],
        ),
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.8,
        currentIndex: currentIndex,
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
        elevation: 10,
        onTap: changePage,
        hasNotch: false,
        hasInk: false,
        inkColor: appColorPrimary.withOpacity(0),
        items: <BubbleBottomBarItem>[
          tab(MyFlutterApp.home, t2_lbl_home),
          tab(MyFlutterApp.calculator, "Calculator"),
          tab(MyFlutterApp.heart, "Favorites"),
        ],
      ),
    );
  }
}

class T2Drawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return T2DrawerState();
  }
}

class T2DrawerState extends State<T2Drawer> {
  var selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        elevation: 8,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: t2_white,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 70, right: 20),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      decoration: new BoxDecoration(
                          color: t2_colorPrimary,
                          borderRadius: new BorderRadius.only(
                              bottomRight: const Radius.circular(24.0),
                              topRight: const Radius.circular(24.0))),
                      /*User Profile*/
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage: AssetImage(t2_profile),
                              radius: 40),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  text(t2_user_name,
                                      textColor: t2_white,
                                      fontFamily: fontBold,
                                      fontSize: textSizeNormal),
                                  SizedBox(height: 8),
                                  text(t2_user_email,
                                      textColor: t2_white,
                                      fontSize: textSizeMedium),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 30),
                getDrawerItem(t2_user, t2_lbl_profile, 1),
                getDrawerItem(t2_chat, t2_lbl_message, 2),
                getDrawerItem(t2_report, t2_lbl_report, 3),
                getDrawerItem(t2_settings, t2_lbl_settings, 4),
                getDrawerItem(t2_logout, t2_lbl_sign_out, 5),
                SizedBox(height: 30),
                Divider(color: t2_view_color, height: 1),
                SizedBox(height: 30),
                getDrawerItem(t2_share, t2_lbl_share_and_invite, 6),
                getDrawerItem(t2_help, t2_lbl_help_and_feedback, 7),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerItem(String icon, String name, int pos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = pos;
        });
      },
      child: Container(
        color: selectedItem == pos ? t2_colorPrimaryLight : t2_white,
        padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          children: <Widget>[
            //SvgPicture.asset(icon, width: 20, height: 20),
            SizedBox(width: 20),
            text(name,
                textColor:
                    selectedItem == pos ? t2_colorPrimary : t2TextColorPrimary,
                fontSize: textSizeLargeMedium,
                fontFamily: fontMedium)
          ],
        ),
      ),
    );
  }
}
