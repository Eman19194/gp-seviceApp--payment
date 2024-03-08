import 'package:flutter/material.dart';
import 'package:gp/View/MakeRequest.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/View/ProviderView/AllRequestProvider.dart';
import 'package:gp/View/SubCategoryTab.dart';

import '../../Model/data/model/CategoriesResponse.dart';
import '../../Model/data/model/CategoryResponse.dart';
import '../../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../../ViewModel/Categories/AllCategoriesVM.dart';
import '../SpecificCategoryScreen.dart';


class HomeTabProvider extends StatefulWidget {
  final String userId;

  const HomeTabProvider({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeTabProviderState createState() => _HomeTabProviderState();
}

class _HomeTabProviderState extends State<HomeTabProvider> {
  AllCategoriesVM viewModel = AllCategoriesVM(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        backgroundColor: MyTheme.backgroundLight,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            image: ExactAssetImage('assets/images/img.png'),
            fit: BoxFit.cover,

            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 58),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyTheme.backgroundLight,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(AppLocalizations.of(context)!.hometext,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllRequestProvider(providerID: widget.userId),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: CircleAvatar(
                                  backgroundColor: MyTheme.primarycol,
                                  radius: 20,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    SizedBox(height: 20,),
                    Text(AppLocalizations.of(context)!.exploreourcategories),
                    FutureBuilder<CategoriesResponse>(
                      future: viewModel.getAllCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<CategoryResponse>? categories = snapshot.data?.data;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: List.generate(
                                  categories!.length,
                                      (index) => InkWell(
                                    onTap: () {
                                      int? categoryId = categories[index]!.id;
                                      print(categoryId);
                                      SpecificCategoryScreen.catId = categoryId!;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SubCategoryTab(
                                            catId: categoryId!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: _buildCategoryCard(categories[index]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryResponse category) {
    return Container(
      width: 150,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Icon(
                  Icons.circle,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  category.name ?? '',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}