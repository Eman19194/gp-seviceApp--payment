import 'dart:typed_data';

import 'package:gp/Model/data/model/AcceptOfferResponse.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/Model/data/model/CategoriesResponse.dart';
import 'package:gp/Model/data/model/DeclineOfferResponse.dart';
import 'package:gp/Model/data/model/DeleteServiceResponse.dart';
import 'package:gp/Model/data/model/ForgetPasswordResponse.dart';
import 'package:gp/Model/data/model/LoginResponse.dart';
import 'package:gp/Model/data/model/MakeReqResponse.dart';
import 'package:gp/Model/data/model/OffersResponse.dart';
import 'package:gp/Model/data/model/ProvideOfferResponse.dart';
import 'package:gp/Model/data/model/ResetPassResponse.dart';
import 'package:gp/Model/data/model/Response.dart';
import 'package:gp/Model/data/model/SignUpResponse.dart';
import 'package:gp/Model/data/model/TimeSlot.dart';
import 'package:gp/Model/data/model/UpdateServiceResponse.dart';
import '../../../Model/data/model/CategoryResponse.dart';
import '../../../Model/data/model/CustomerRequestsresponse.dart';
import '../../../Model/data/model/SubcategoriesResponse.dart';
import '../../../Model/data/model/SubcategoryResponse.dart';


abstract class AuthRepoContract {
  Future<SignUpResponse> signUp(
      String email, String password, String confirmPassword);
  Future<SignUpResponse> signUpProvider(String email, String password, String confirmPassword);
  Future<LoginResponse> login(String email, String password);
  Future<ForgetPasswordResponse> forgetPassword(String email);
  Future<ResetPassResponse> resetPassword(String email, String password, String confirmPassword);
  Future<CategoriesResponse> getAllCategories();
  Future<CategoryResponse> getSpecificCategory(int catId);
  Future<SubcategoriesResponse> getAllSubcategories();
  Future<SubcategoryResponse> getSpecificSubcategory(int subcatId);
  Future<SubcategoriesResponse> getSubcategoriesOfCategory(int catId);
  Future<List<CustomerRequestsresponse>> getAllRequests(String customerID);
  Future<List<CustomerRequestsresponse>> getAllRequestsProvider();
  Future<MakeReqResponse> makeRequest(String customerID, int catID,int id,String description,String location,Uint8List _imageBytes);
  Future<UpdateServiceResponse> updateRequest(int serviceID,String description,String location, Uint8List imageBytes);
  Future<DeleteServiceResponse> deleteService(int serviceID);
  Future<Response> timeSlot(List<DateTime> selectedDateTimeList,int serviceID);
  Future<TimeSlot> specificTimeSlot(int timeslotID);
  Future<List<OffersResponse>> getOffers(int serviceID);
  Future<AcceptOfferResponse> acceptOffer(int offerID);
  Future<DeclineOfferResponse> declineOffer(int offerID);
  Future<List<AllTimeSlotsResponse>> getAllTimeSlots(int serviceID);
  Future<ProvideOfferResponse> providerOffer(String providerID,int serviceID,int fees,int timeID,String duration);
  Future<List<OffersResponse>> getProviderOffers(String providerID);
  Future<ProvideOfferResponse> updateOffer(int offerID,int fees,int timeID,String duration);
  Future<DeleteServiceResponse> cancelOffer(int offerID);
}