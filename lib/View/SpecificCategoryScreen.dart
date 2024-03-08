import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/View/MyTheme.dart';
import '../Model/data/model/SubcategoryResponse.dart';
import '../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../ViewModel/Subcategories/SpecificSubcategoryVM.dart';

class SpecificCategoryScreen extends StatelessWidget {
  static const String routeName = 'spacicScreen';
  static int catId = 0;

  final SpecificSubcategoryVM viewModel = SpecificSubcategoryVM(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.subCategoryDetails),
      ),
      body: FutureBuilder<SubcategoryResponse>(
        future: viewModel.getSpecificSubcategory(catId),
        builder: (context, AsyncSnapshot<SubcategoryResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(AppLocalizations.of(context)!.nodataavailable),
            );
          } else {
            SubcategoryResponse category = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryDetail(AppLocalizations.of(context)!.name, category.name ?? '-'),
                  SizedBox(height: 16),
                  _buildCategoryDetail(AppLocalizations.of(context)!.description, category.description ?? '-'),
                  SizedBox(height: 16),
                  _buildCategoryDetail(AppLocalizations.of(context)!.minFees,category.minFees.toString()  ),
                  SizedBox(height: 16),
                  _buildCategoryDetail(AppLocalizations.of(context)!.maxfees,category.maxFees.toString()  ),


                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoryDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: MyTheme.primarycol),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
