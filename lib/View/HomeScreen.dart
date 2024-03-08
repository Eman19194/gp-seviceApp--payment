
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gp/View/CategoryTab.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/View/RequestsTab.dart';
import 'package:gp/View/profileTab.dart';
import '../Model/data/model/CategoriesResponse.dart';
import '../Model/data/model/CategoryResponse.dart';
import '../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../ViewModel/Categories/AllCategoriesVM.dart';
import 'HomeTab.dart';
import 'SettingTab.dart';
import 'SpecificCategoryScreen.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AllCategoriesVM viewModel = AllCategoriesVM(inJectAuthRepoContract());

  final _pageController = PageController(initialPage: 0);
  int maxCount = 5;
  var userId;
  int selectedIndex = 0;
  late List<Widget> tabs;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
     if (arguments != null && arguments is String) {
       userId = arguments;
     } else {
       userId = ""; // Default value
     }
    tabs = [HomeTab(userId : userId), CategoryTab(), RequestsTab(userId: userId), ProfileTab(), SettingTab()];
    return Scaffold(
      body:
        PageView(
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
            child: Icon(Icons.border_all, color: Colors.white),
            label: AppLocalizations.of(context)!.categories,
            labelStyle: TextStyle(color: Colors.white,fontSize: 15),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.list_alt_rounded, color: Colors.white),
            label: AppLocalizations.of(context)!.requests,
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
  Widget _buildCategoryCard(CategoryResponse category) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.all(8),
          //   child: Text(
          //     (category.id?? " ") as String,
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child:  Text(
                "${category.name ?? ''}",
                style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),
              ) ,
            ),

          ),

        ],
      ),
    );
  }
}


