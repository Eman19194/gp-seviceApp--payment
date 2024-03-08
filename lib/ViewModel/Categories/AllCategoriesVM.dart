import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';

import '../../Model/data/model/CategoriesResponse.dart';
import 'CategoriesStates.dart';

class AllCategoriesVM extends Cubit<CategoriesStates> {
  final AuthRepoContract repoContract;

  AllCategoriesVM(this.repoContract) : super(CategoriesInitialState());

  Future<CategoriesResponse> getAllCategories() async {
    try {
      emit(CategoriesLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getAllCategories();

      if (response.data.isEmpty) {
        emit(CategoriesErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('Failed to fetch categories. Response is empty.');
      } else {
        emit(CategoriesSuccessState(response: response));
        print('Categories fetched successfully: $response');
      }

      return response;
    } catch (e) {
      emit(CategoriesErrorState(errorMessage: 'Error fetching categories: $e')); // Handle error
      return CategoriesResponse(data: []);
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
