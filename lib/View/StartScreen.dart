
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/View/LoginScreen.dart';
import 'package:gp/View/MyTheme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'HomeScreen.dart';
import 'ProviderView/LoginScreenProvider.dart';
import 'main.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = "Start";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   FirebaseMessaging.onMessage.listen(showFlutterNotification);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //  backgroundColor:MyTheme.backgroundLight,
      // ),

      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Image.asset(
                'assets/images/logo.png',
                width: 300.w,
                height: 200.h,
                fit: BoxFit.contain,
              ),
            ),
            Text(AppLocalizations.of(context)!.welcome, style: Theme.of(context).textTheme.titleLarge),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.w),
              child: Text(AppLocalizations.of(context)!.continueAs,style: Theme.of(context).textTheme.bodyMedium),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.primarycol,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(25.r)))),
              child: Container(
                height: 64.h,
                width: 280.w,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.user,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        color: MyTheme.backgroundLight,
                        fontSize: 20.sp),
                  ),
                ),
              ),

            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 80.h, // Adjust the height of the divider line
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      AppLocalizations.of(context)!.or,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 80.h, // Adjust the height of the divider line
                    ),
                  ),
                ],
              ),
            ),

            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context,LoginScreenProvider.routeName);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: MyTheme.primarycol), // Add a border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.r)),
                ),
              ),
              child: Container(
                height: 64.h,
                width: 280.w,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.provider,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: MyTheme.primarycol, // Set text color to match border color
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
