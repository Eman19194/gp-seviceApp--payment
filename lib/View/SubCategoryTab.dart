import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/Model/data/model/SubcategoriesResponse.dart';

import '../Model/data/model/SubcategoryResponse.dart';
import '../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../ViewModel/Categories/AllCategoriesVM.dart';
import '../ViewModel/Subcategories/AllSubategoriesVM.dart';
import 'SpecificCategoryScreen.dart';

class SubCategoryTab extends StatefulWidget {
  static const String routeName = "SubCategory";

  final int catId ;
  const SubCategoryTab({Key? key, required this.catId}) : super(key: key);


  @override
  _SubCategoryTabState createState() => _SubCategoryTabState();
}

class _SubCategoryTabState extends State<SubCategoryTab> {
  AllSubcategoriesVM viewModel = AllSubcategoriesVM(inJectAuthRepoContract());
  List<SubcategoryResponse> subcategories = [];

  @override
  void initState(){
    super.initState();
    viewModel.getAllSubcategories(widget.catId).then((response) {
      subcategories = response.data;
      print("dfd");
      print(widget.catId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.subCategory),//sub
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        height: double.infinity,
        child: SingleChildScrollView(
          child: FutureBuilder<SubcategoriesResponse>( //-->>
            future: viewModel.getAllSubcategories(widget.catId),
             builder: (context, AsyncSnapshot<SubcategoriesResponse> snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {

                print(widget.catId);
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {              // not sure
                List<SubcategoryResponse>? categories = snapshot.data?.data;
                print(categories);

                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: categories!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        int? subcategoryId = categories[index].id;
                        print(subcategoryId);
                        SpecificCategoryScreen.catId = subcategoryId!;
                        Navigator.pushNamed(context, SpecificCategoryScreen.routeName);
                      },
                      child: _buildCategoryCard(categories[index]),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(SubcategoryResponse category) {
    return Card(
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
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  category.description ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}