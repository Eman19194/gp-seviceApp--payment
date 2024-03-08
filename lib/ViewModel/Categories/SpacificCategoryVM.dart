import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/data/model/CategoryResponse.dart';
import '../../Repository/repository/repository/auth_repository_contract.dart';

import 'SpacificCategoryStates.dart';

class SpacificCategoryVM extends Cubit<SpacificCategoryStates> {
  SpacificCategoryVM(this.repoContract) : super(SpacificCategoryInitialState());
  AuthRepoContract repoContract;
  Future<CategoryResponse> getSpacificCategory(int catId) async {
    try {
      emit(SpacificCategoryLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getSpecificCategory(catId);

      if (response.name==null) {
        emit(SpacificCategoryErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('Failed to fetch categories. Response is empty.');
      } else {
        emit(SpacificCategorySuccessState(response: response));
        print('Categories fetched successfully: $response');
      }

      return response;
    } catch (e) {
      emit(SpacificCategoryErrorState(errorMessage: 'Error fetching categories: $e')); // Handle error
      return CategoryResponse(description: "");
    }
  }
}