import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/View/SubCategoryTab.dart';
import '../Model/data/model/CategoriesResponse.dart';
import '../Model/data/model/CategoryResponse.dart';
import '../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../ViewModel/Categories/AllCategoriesVM.dart';
import 'SpecificCategoryScreen.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  AllCategoriesVM viewModel = AllCategoriesVM(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.all_categories),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        height: double.infinity,
        child: SingleChildScrollView(
          child: FutureBuilder<CategoriesResponse>(
            future: viewModel.getAllCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<CategoryResponse>? categories = snapshot.data?.data;
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
                        int? categoryId = categories[index].id;
                        print(categoryId);
                       // SubCategoryTab = categoryId!;
                      //  SpecificCategoryScreen.catId = categoryId!;
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => SubCategoryTab(
                        catId: categoryId!,
                        ),
                        ),
                        ).then((value) { setState(() {});});
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

  Widget _buildCategoryCard(CategoryResponse category) {
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