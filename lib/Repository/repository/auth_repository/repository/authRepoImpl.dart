import 'dart:typed_data';

import 'package:gp/Model/data/model/AcceptOfferResponse.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/Model/data/model/DeclineOfferResponse.dart';
import 'package:gp/Model/data/model/DeleteServiceResponse.dart';
import 'package:gp/Model/data/model/ForgetPasswordResponse.dart';
import 'package:gp/Model/data/model/MakeReqResponse.dart';
import 'package:gp/Model/data/model/OffersResponse.dart';
import 'package:gp/Model/data/model/ProvideOfferResponse.dart';
import 'package:gp/Model/data/model/ResetPassResponse.dart';
import 'package:gp/Model/data/model/Response.dart';
import 'package:gp/Model/data/model/TimeSlot.dart';
import 'package:gp/Repository/repository/repository/auth_repository_contract.dart';
import 'package:gp/Model/data/model/LoginResponse.dart';
import 'package:gp/Model/data/model/CategoryResponse.dart';
import 'package:gp/Model/data/model/SignUpResponse.dart';
import '../../../../Model/data/model/CategoriesResponse.dart';
import '../../../../Model/data/model/CustomerRequestsresponse.dart';
import '../../../../Model/data/model/SubcategoriesResponse.dart';
import '../../../../Model/data/model/SubcategoryResponse.dart';
import '../../../../Model/data/model/UpdateServiceResponse.dart';
import '../../data_source/auth_data_source.dart';
import '../data_source/authDataSourceImpl.dart';

class AuthRepoImpl implements AuthRepoContract {
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<SignUpResponse> signUp(
      String email, String password, String confirmPassword) async {
    return authRemoteDataSource.signUp(email, password, confirmPassword);
  }
  @override
  Future<SignUpResponse> signUpProvider(String email, String password, String confirmPassword) async{
   return authRemoteDataSource.signUpProvider(email, password, confirmPassword);
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    return authRemoteDataSource.login(email, password);
  }
  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async{
    return authRemoteDataSource.forgetPassword(email);
  }

  @override
  Future<ResetPassResponse> resetPassword(String email, String password, String confirmPassword)async {
    return authRemoteDataSource.resetPassword( email, password, confirmPassword);
  }

  @override
  Future<CategoriesResponse> getAllCategories() async {
    return authRemoteDataSource.getAllCategories();
  }

  @override
  Future<CategoryResponse> getSpecificCategory(int catId) async {
    return authRemoteDataSource.getSpecificCategory(catId);
  }

  @override
  Future<List<CustomerRequestsresponse>> getAllRequests(String customerID) async{
    return authRemoteDataSource.getAllRequests(customerID);
  }
  @override
  Future<List<CustomerRequestsresponse>> getAllRequestsProvider() async{
    return authRemoteDataSource.getAllRequestsProvider();
  }

  @override
  Future<MakeReqResponse> makeRequest(String customerID, int catID, int id, String description, String location,Uint8List _imageBytes) {
    return authRemoteDataSource.makeRequest(customerID, catID, id, description, location,_imageBytes);
  }
  @override
  Future<Response> timeSlot(List<DateTime> selectedDateTimeList,int serviceID) {
    return authRemoteDataSource.timeSlot(selectedDateTimeList, serviceID);
  }
  @override
  Future<TimeSlot> specificTimeSlot(int timeslotID) {
    return authRemoteDataSource.specificTimeSlot(timeslotID);
  }
  @override
  Future<List<OffersResponse>> getOffers(int serviceID){
    return authRemoteDataSource.getOffers(serviceID);
  }
  @override
  Future<AcceptOfferResponse> acceptOffer(int offerID) async{
    return authRemoteDataSource.acceptOffer(offerID);
  }
  @override
  Future<DeclineOfferResponse> declineOffer(int offerID)async{
    return authRemoteDataSource.declineOffer(offerID);
  }
  @override
  Future<UpdateServiceResponse> updateRequest(int serviceID,String description,String location, Uint8List imageBytes)async{
    return authRemoteDataSource.updateRequest(serviceID, description, location, imageBytes);
  }
  @override
  Future<DeleteServiceResponse> deleteService(int serviceID)async{
    return authRemoteDataSource.deleteService(serviceID);
  }

  @override
  Future<SubcategoriesResponse> getAllSubcategories() async {
    return authRemoteDataSource.getAllSubcategories();
  }

  @override
  Future<SubcategoryResponse> getSpecificSubcategory(int subcatId) async {
    return authRemoteDataSource.getSpecificSubcategory(subcatId);
  }

  @override
  Future<SubcategoriesResponse> getSubcategoriesOfCategory(int catId) async {
    return authRemoteDataSource.getSubcategoriesOfCategory(catId);
  }
  @override
  Future<List<AllTimeSlotsResponse>> getAllTimeSlots(int serviceID) async{
    return authRemoteDataSource.getAllTimeSlots(serviceID);
  }
  @override
  Future<ProvideOfferResponse> providerOffer(String providerID,int serviceID,int fees,int timeID,String duration)async {
    return authRemoteDataSource.providerOffer(
        providerID, serviceID, fees, timeID, duration);
  }
  @override
  Future<List<OffersResponse>> getProviderOffers(String providerID) async {
    return authRemoteDataSource.getProviderOffers(providerID);
  }
  @override
  Future<ProvideOfferResponse> updateOffer(int offerID,int fees,int timeID,String duration)async {
    return authRemoteDataSource.updateOffer(offerID, fees, timeID, duration);
  }
  @override
  Future<DeleteServiceResponse> cancelOffer(int offerID)async {
    return authRemoteDataSource.cancelOffer(offerID);
  }
}

AuthRepoContract inJectAuthRepoContract() {
  return AuthRepoImpl(authRemoteDataSource: inJectAuthDataSource());
}
