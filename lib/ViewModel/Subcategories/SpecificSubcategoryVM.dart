import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/data/model/SubcategoryResponse.dart';
import '../../Repository/repository/repository/auth_repository_contract.dart';
import 'SpecificSubcategoryStates.dart';


class SpecificSubcategoryVM extends Cubit<SpecificSubcategoryStates> {
  SpecificSubcategoryVM(this.repoContract) : super(SpecificSubcategoryInitialState());
  AuthRepoContract repoContract;
  Future<SubcategoryResponse> getSpecificSubcategory(int catId) async {
    try {
      emit(SpecificSubcategoryLoadingState(loadingMessage: "Loading..."));
      var response = await repoContract.getSpecificSubcategory(catId);

      if (response.name==null) {
        emit(SpecificSubcategoryErrorState(errorMessage: 'Empty response')); // Handle empty response
        print('Failed to fetch subcategories. Response is empty.');
      } else {
        emit(SpecificSubcategorySuccessState(response: response));
        print('Subcategories fetched successfully: $response');
      }
      return response;
    } catch (e) {
      emit(SpecificSubcategoryErrorState(errorMessage: 'Error fetching subcategories: $e')); // Handle error
      return SubcategoryResponse(description: "");
    }
  }
}