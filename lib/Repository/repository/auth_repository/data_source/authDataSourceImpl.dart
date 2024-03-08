import 'dart:typed_data';

import 'package:gp/Model/data/model/AcceptOfferResponse.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/Model/data/model/CustomerRequestsresponse.dart';
import 'package:gp/Model/data/model/DeleteServiceResponse.dart';
import 'package:gp/Model/data/model/ForgetPasswordResponse.dart';
import 'package:gp/Model/data/model/MakeReqResponse.dart';
import 'package:gp/Model/data/model/OffersResponse.dart';
import 'package:gp/Model/data/model/ProvideOfferResponse.dart';
import 'package:gp/Model/data/model/ResetPassResponse.dart';
import 'package:gp/Model/data/model/TimeSlot.dart';
import 'package:gp/Model/data/model/UpdateServiceResponse.dart';
import '../../../../Model/data/api/ApiManager.dart';
import '../../../../Model/data/model/CategoriesResponse.dart';
import '../../../../Model/data/model/CategoryResponse.dart';
import '../../../../Model/data/model/DeclineOfferResponse.dart';
import '../../../../Model/data/model/LoginResponse.dart';
import '../../../../Model/data/model/SignUpResponse.dart';
import '../../../../Model/data/model/Response.dart';
import '../../../../Model/data/model/SubcategoriesResponse.dart';
import '../../../../Model/data/model/SubcategoryResponse.dart';
import '../../data_source/auth_data_source.dart';

class AuthDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;

  AuthDataSourceImpl({required this.apiManager});

  @override
  Future<SignUpResponse> signUp(
      String email, String password, String confirmPassword) async {
    var response = await apiManager.signUp(email, password, confirmPassword);
    return response;
  }
  @override
  Future<SignUpResponse> signUpProvider(String email, String password, String confirmPassword) async{
    var response = await apiManager.signUpProvider(email, password, confirmPassword);
    return response;
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    var response = await apiManager.login(email, password);
    return response;
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async{
    var response = await apiManager.forgetPassword(email);
    return response;
  }
  @override
  Future<ResetPassResponse> resetPassword(String email, String password, String confirmPassword)async {
    var response = await apiManager.resetPassword(email, password, confirmPassword);
    return response;
  }

  @override
  Future<CategoriesResponse> getAllCategories() async {
    var response = await apiManager.getAllCategories();
    return response;
  }

  @override
  Future<CategoryResponse> getSpecificCategory(int catId) async {
    var response = await apiManager.getSpecificCategory(catId);
    return response;
  }

  @override
  Future<SubcategoriesResponse> getAllSubcategories() async {
    var response = await apiManager.getAllSubcategories();
    return response;
  }

  @override
  Future<SubcategoryResponse> getSpecificSubcategory(int subcatId) async{
    var response = await apiManager.getSpecificSubcategory(subcatId);
    return response;
  }

  @override
  Future<SubcategoriesResponse> getSubcategoriesOfCategory(int catId) async{
    var response = await apiManager.getSubcategoriesOfCategory(catId);
    return response;
  }

  @override
  Future<List<CustomerRequestsresponse>> getAllRequests(String customerID) async{
    var response = await apiManager.getAllRequests(customerID);
    return response;
  }
  @override
  Future<List<CustomerRequestsresponse>> getAllRequestsProvider() async{
    var response = await apiManager.getAllRequestsProvider();
    return response;
  }

  @override
  Future<MakeReqResponse> makeRequest(String customerID, int catID, int id, String description, String location,Uint8List _imageBytes) async {
    var response = await apiManager.makeRequest(customerID, catID, id, description, location,_imageBytes);
    return response;
  }

  @override
  Future<Response> timeSlot(List<DateTime> selectedDateTimeList, int serviceID) async {
    var response = await apiManager.timeSlot(selectedDateTimeList, serviceID);
    return response;
  }

  @override
  Future<TimeSlot> specificTimeSlot(int timeslotID) async {
    var response = await apiManager.specificTimeSlot(timeslotID);
    return response;
  }

  @override
  Future<List<OffersResponse>> getOffers(int serviceID)async {
    var response = await apiManager.getOffers(serviceID);
    return response;
  }

  @override
  Future<AcceptOfferResponse> acceptOffer(int offerID) async{
    var response = await apiManager.acceptOffer(offerID);
    return response;
  }
  @override
  Future<DeclineOfferResponse> declineOffer(int offerID)async{
    var response = await apiManager.declineOffer(offerID);
    return response;
  }
  @override
  Future<UpdateServiceResponse> updateRequest(int serviceID,String description,String location, Uint8List imageBytes)async{
    var response = await apiManager.updateRequest(serviceID, description, location, imageBytes);
    return response;
  }
  @override
  Future<DeleteServiceResponse> deleteService(int serviceID)async{
    var response = await apiManager.deleteService(serviceID);
    return response;
  }
  @override
  Future<List<AllTimeSlotsResponse>> getAllTimeSlots(int serviceID) async{
    var response = await apiManager.getAllTimeSlots(serviceID);
    return response;
  }
  @override
  Future<ProvideOfferResponse> providerOffer(String providerID,int serviceID,int fees,int timeID,String duration)async{
    var response = await apiManager.providerOffer(providerID, serviceID, fees, timeID, duration);
    return response;
  }
  @override
  Future<List<OffersResponse>> getProviderOffers(String providerID) async {
    var response = await apiManager.getProviderOffers(providerID);
    return response;
  }
  @override
  Future<ProvideOfferResponse> updateOffer(int offerID,int fees,int timeID,String duration)async {
    var response = await apiManager.updateOffer(offerID, fees, timeID, duration);
    return response;
  }
  @override
  Future<DeleteServiceResponse> cancelOffer(int offerID)async {
    var response = await apiManager.cancelOffer(offerID);
    return response;
  }

}

AuthRemoteDataSource inJectAuthDataSource() {
  return AuthDataSourceImpl(apiManager: ApiManager.getInstance());
}
