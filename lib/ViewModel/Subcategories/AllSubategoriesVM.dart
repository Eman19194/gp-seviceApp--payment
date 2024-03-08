import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

import '../../Model/data/model/SubcategoriesResponse.dart';
import 'SubcategoriesStates.dart';


class AllSubcategoriesVM extends Cubit<SubcategoriesStates> {
  final AuthRepoContract repoContract;

  AllSubcategoriesVM(this.repoContract) : super(SubcategoriesInitialState());

  Future<SubcategoriesResponse> getAllSubcategories(int catId) async {
    try {
      emit(SubcategoriesLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getSubcategoriesOfCategory(catId);

      if (response.data.isEmpty) {
        emit(SubcategoriesErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('Failed to fetch subcategories. Response is empty.');
      } else {
        emit(SubcategoriesSuccessState(response: response));
        print('Subcategories fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(SubcategoriesErrorState(errorMessage: 'Error fetching subcategories: $e')); // Handle error
      return SubcategoriesResponse(data: []);
    }
  }
}




// class AllCategoriesVM extends Cubit<CategoriesStates> {
//   AllCategoriesVM(this.repoContract) : super(CategoriesInitialState());
//   AuthRepoContract repoContract;
//   Future<CategoryResponse> getAllCategories() async {
//     try {
//       emit(CategoriesLoadingState(loadingMessage: "Loading..."));
//       var response = await repoContract.getAllCategories();
//
//       if (response.description!.isEmpty) {
//         emit(CategoriesErrorState(errorMessage: response.description.toString()));
//         print('Failed to categories.>>>>>>>>>>>> ${response.description}');
//       } else {
//         emit(CategoriesSuccessState(response: response));
//         print('categories Successful.>>>>>>>> ${response.description}');
//       }
//
//       return response;  // Return the response
//     } catch (e) {
//       emit(CategoriesErrorState(errorMessage: e.toString()));
//       // Return an empty response or handle the error accordingly
//       return CategoryResponse();
//     }
//   }
//
//   }
