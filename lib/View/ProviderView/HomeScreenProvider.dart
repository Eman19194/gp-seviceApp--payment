
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gp/View/CategoryTab.dart';
import 'package:gp/View/HomeTab.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/View/ProviderView/AllRequestProvider.dart';
import 'package:gp/View/RequestsTab.dart';
import 'package:gp/View/SettingTab.dart';
import 'package:gp/View/profileTab.dart';

import 'HistoryTab.dart';
import 'HomeTabProvider.dart';



class HomeScreenProvider extends StatefulWidget {
  static const String routeName = "homeP";

  @override
  State<HomeScreenProvider> createState() => _HomeScreenProviderState();
}

class _HomeScreenProviderState extends State<HomeScreenProvider> {
  final _pageController = PageController(initialPage: 0);
  int maxCount = 5;
  var providerID;
  int selectedIndex = 0;
  late List<Widget> tabs;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
     if (arguments != null && arguments is String) {
       providerID = arguments;
     } else {
  providerID = ""; // Default value
  }
    tabs = [HomeTabProvider(userId:providerID),AllRequestProvider(providerID:providerID),HistoryTab(providerId: providerID), ProfileTab(), SettingTab()];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: tabs,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined, color: Colors.white),
            label: AppLocalizations.of(context)!.home,
            labelStyle: TextStyle(color: Colors.white,fontSize: 15),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.list_alt_rounded, color: Colors.white),
            label: AppLocalizations.of(context)!.requests,
            labelStyle: TextStyle(color: Colors.white,fontSize: 15),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.history, color: Colors.white),
            label: AppLocalizations.of(context)!.history,
            labelStyle: TextStyle(color: Colors.white,fontSize: 15),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, color: Colors.white),
            label: AppLocalizations.of(context)!.profile,
            labelStyle: TextStyle(color: Colors.white,fontSize: 15),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings, color: Colors.white),
            label: AppLocalizations.of(context)!.settings,
            labelStyle: TextStyle(color: Colors.white,fontSize: 15),
          ),
        ],
        color: MyTheme.primarycol,
        buttonBackgroundColor: MyTheme.primarycol,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
        letIndexChange: (index) => true,
      ),

    );
  }

}


