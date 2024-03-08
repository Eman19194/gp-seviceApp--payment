import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/providers/SettingsProvider.dart';
import 'package:provider/provider.dart';
import 'StartScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName="splashScreen";
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:1),
          ()=>Navigator.of(context).pushNamed(StartScreen.routeName),
    );
  }
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.primarycol,
        image:DecorationImage(
          image: AssetImage(settingsProvider.getSplash()),
          fit: BoxFit.contain,
        ),

      ),
    );
  }
}