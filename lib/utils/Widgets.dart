import 'package:cannabis_calculator/utils/AppColors.dart';
import 'package:cannabis_calculator/utils/Colors.dart';
import 'package:cannabis_calculator/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Text headerText(var text) {
  return Text(
    text,
    maxLines: 2,
    style: TextStyle(
        fontFamily: fontBold, fontSize: 22, color: t2_textColorPrimary),
  );
}

Text subHeadingText(var text) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: fontBold, fontSize: 17.5, color: t2_textColorSecondary),
  );
}

Widget text(var text,
    {var fontSize = textSizeLargeMedium,
    textColor = t2_textColorSecondary,
    var fontFamily = fontRegular,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          letterSpacing: latterSpacing));
}

class AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  AppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return AppButtonState();
  }
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: widget.onPressed,
        textColor: t2_white,
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[t2_colorPrimary, t2_colorPrimaryDark]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

/**/
class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  TextEditingController mController;

  VoidCallback onPressed;

  EditText(
      {var this.fontSize = textSizeNormal,
      var this.textColor = t2_textColorSecondary,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: t2_colorPrimary,
        maxLines: widget.maxLine,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: t2TextColorPrimary,
            fontFamily: widget.fontFamily),
      );
    } else {
      return TextField(
          controller: widget.mController,
          obscureText: widget.isPassword,
          cursorColor: t2_colorPrimary,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: t2TextColorPrimary,
              fontFamily: widget.fontFamily),
          decoration: new InputDecoration(
            suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPassword = !widget.isPassword;
                });
              },
              child: new Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off),
            ),
          ));
    }
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

Widget checkbox(String title, bool boolValue) {
  return Row(
    children: <Widget>[
      Text(title),
      Checkbox(
        activeColor: t2_colorPrimary,
        value: boolValue,
        onChanged: (bool value) {
          boolValue = value;
        },
      )
    ],
  );
}

class TopBar extends StatefulWidget {
  var titleName;
  Color bgColor;

  TopBar(var this.titleName, {this.bgColor = Colors.white});

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    double sizeWidth = MediaQuery.of(context).size.width;
    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      width: MediaQuery.of(context).size.width,
      height: statusbarHeight + 50,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              //Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: sizeWidth*0),
            child: Text(
              widget.titleName,
              style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Bold"),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [appColorAccent, appColorPrimary],
              begin: const FractionalOffset(0.0, 4),
              end: const FractionalOffset(0.4, 0.8),
              stops: [0.0, 0.0],
              tileMode: TileMode.clamp
          ),
          boxShadow: [
            new BoxShadow(
                color: Colors.grey[500],
                blurRadius: 0.0,
                spreadRadius: 0.0
            )
          ]
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

class TopBarCenter extends StatefulWidget {
  var titleName;
  Color bgColor;

  TopBarCenter(var this.titleName, {this.bgColor = Colors.white});

  @override
  State<StatefulWidget> createState() {
    return TopBarCenterState();
  }
}

class TopBarCenterState extends State<TopBarCenter> {
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    double sizeWidth = MediaQuery.of(context).size.width;
    return new Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: statusbarHeight + 10, left: sizeWidth * (1/25)),
        //width: MediaQuery.of(context).size.width*(widget.titleName.toString().length),
        height: statusbarHeight + 50,
      child: Text(
        widget.titleName,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 20.0,
            foreground: Paint()
            ..shader = LinearGradient(
                colors: <Color>[appColorPrimaryGold, appColorPrimary],
                tileMode: TileMode.clamp
            ).createShader(Rect.fromLTRB(1500, 0, 0, 0)),
            fontWeight: FontWeight.bold, fontFamily: "Bold"),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: const FractionalOffset(0.0, 10),
            end: const FractionalOffset(0.1, 1),
            stops: [0.0, 2.0],
            tileMode: TileMode.clamp
        ),
        ),
      );
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

Widget ring(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(
            width: 16.0,
            color: t2_colorPrimary,
          ),
        ),
      ),
      SizedBox(height: 16),
      text(description,
          textColor: t2TextColorPrimary,
          fontSize: textSizeNormal,
          fontFamily: fontSemibold,
          isCentered: true,
          maxLine: 2)
    ],
  );
}

Widget shareIcon(String iconPath, Color tintColor) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.fill),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = t2_white,
    var showShadow = false}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: bgColor,
      boxShadow: showShadow
          ? [BoxShadow(color: shadow_color, blurRadius: 10, spreadRadius: 2)]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

class ScrollingBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/*
Widget checkbox(String title, bool boolValue) {
  return Row(
    children: <Widget>[
      Text(title),
      Checkbox(
        activeColor: t2_colorPrimary,
        value: boolValue,
        onChanged: (bool value) {
          boolValue=value;
        },
      )
    ],
  );
}
*/
