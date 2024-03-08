import 'dart:convert';
import 'dart:typed_data';
import 'package:gp/Model/data/model/AcceptOfferResponse.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/Model/data/model/CategoriesResponse.dart';
import 'package:gp/Model/data/model/CustomerRequestsresponse.dart';
import 'package:gp/Model/data/model/DeclineOfferResponse.dart';
import 'package:gp/Model/data/model/DeleteServiceResponse.dart';
import 'package:gp/Model/data/model/ForgetPasswordResponse.dart';
import 'package:gp/Model/data/model/MakeReqResponse.dart';
import 'package:gp/Model/data/model/OffersResponse.dart';
import 'package:gp/Model/data/model/ProvideOfferResponse.dart';
import 'package:gp/Model/data/model/ProviderOfferRequest.dart';
import 'package:gp/Model/data/model/ResetPassResponse.dart';
import 'package:gp/Model/data/model/Response.dart';
import 'package:gp/Model/data/model/TimeSlot.dart';
import 'package:gp/Model/data/model/UpdateServiceResponse.dart';
import 'package:http/http.dart' as http;

import '../model/CategoryResponse.dart';
import '../model/LoginRequest.dart';
import '../model/LoginResponse.dart';
import '../model/SignUpRequest.dart';
import '../model/SignUpResponse.dart';
import '../model/SubcategoriesResponse.dart';
import '../model/SubcategoryResponse.dart';
import 'Apiconstants.dart';


class ApiManager {
  ApiManager._();

  static ApiManager? _instance;

  factory ApiManager.getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<SignUpResponse> signUp(String email, String password, String confirmPassword) async {
    Uri url = Uri.https(Apiconstants.baseUrl, Apiconstants.signupApi);
    var requestBody = SignUpRequest(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    // var response = await http.post(url, body: jsonEncode(requestBody));
    // return SignUpResponse.fromJson(jsonDecode(response.body));
    var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestBody),
        );
    if (response.statusCode == 200) {
      return SignUpResponse.fromJson(jsonDecode(response.body));
    } else {
      print('signUp failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = SignUpResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error me ssage
    }
  }
  Future<SignUpResponse> signUpProvider(String email, String password, String confirmPassword) async {
    Uri url = Uri.https(Apiconstants.baseUrl, Apiconstants.signupProviderApi);
    var requestBody = SignUpRequest(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      return SignUpResponse.fromJson(jsonDecode(response.body));
    } else {
      print('signUp failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = SignUpResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error me ssage

    }


  }

  Future<LoginResponse> login(String email, String password) async {
      Uri url = Uri.https(Apiconstants.baseUrl, Apiconstants.loginApi);
      var requestBody = LoginRequest(
        email: email,
        password: password,
      );

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        print('Login failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        var errorMessage = LoginResponse.fromJson(jsonDecode(response.body)).message;
          print('Error message: $errorMessage');
          throw Exception(errorMessage); // Throw the specific error me ssage
      }
  }

  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    Uri url = Uri.https(Apiconstants.baseUrl, '/api/Auth/ForgetPassword/$email');
    var response = await http.post(url);
    if (response.statusCode == 200) {
      return ForgetPasswordResponse.fromJson(jsonDecode(response.body));
    } else {
      print('ForgetPassword failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = ForgetPasswordResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error me ssage

    }
  }

  Future<ResetPassResponse> resetPassword(String email, String password, String confirmPassword) async {
    Uri url = Uri.https(Apiconstants.baseUrl, Apiconstants.resetPassword);
    var requestBody = SignUpRequest(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      return ResetPassResponse.fromJson(jsonDecode(response.body));
    } else {
      print('ResetPassword failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = ResetPassResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error message
    }
  }

  Future<CategoriesResponse> getAllCategories() async {
    Uri url = Uri.https(Apiconstants.baseUrl, Apiconstants.AllCategories);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // return CategoriesResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return CategoriesResponse.fromJson(jsonDecode(response.body));
    } else {
      print('categories failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = CategoryResponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error me ssage
    }
  }

  Future<CategoryResponse> getSpecificCategory(int catId) async {
    Uri url = Uri.https(Apiconstants.baseUrl, '/api/Category/$catId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(jsonDecode(response.body));
    } else {
      print('getSpecificCategory failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = CategoryResponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error message
    }
  }

  Future<SubcategoriesResponse> getAllSubcategories() async {
    Uri url = Uri.https(Apiconstants.baseUrl, Apiconstants.AllSubcategories);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // return SubcategoriesResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return SubcategoriesResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Subcategories failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = SubcategoryResponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error message
    }
  }

  Future<SubcategoryResponse> getSpecificSubcategory(int subcatId) async {
    Uri url = Uri.https(Apiconstants.baseUrl, '/api/Subcategory/$subcatId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return SubcategoryResponse.fromJson(jsonDecode(response.body));
    } else {
      print('getSpecificCategory failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = SubcategoryResponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error message
    }
  }

  Future<SubcategoriesResponse> getSubcategoriesOfCategory(int catId) async {
    Uri url = Uri.https(Apiconstants.baseUrl, '/api/Subcategory/OfCategory/$catId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return SubcategoriesResponse.fromJson(jsonDecode(response.body));
    } else {
      print('getSubcategoriesOfCategory failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = SubcategoryResponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error message
    }
  }

  Future<List<CustomerRequestsresponse>> getAllRequests(String customerID) async {
    Uri url = Uri.https(Apiconstants.baseUrl, '/api/ServiceRequest/CustomerRequests/$customerID');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<CustomerRequestsresponse> requests = [];
      List<dynamic> jsonResponse = json.decode(response.body);
      for (var item in jsonResponse) {
        if (item is Map<String, dynamic> && item.containsKey('image')) {
          dynamic imageData = item['image'];
          if (imageData is String) {
            Uint8List imageBytes = base64Decode(imageData);
            item['image'] = imageBytes; // Replace base64 string with Uint8List
          } else {
            throw Exception('Image data is not a string');
          }
        } else {
          throw Exception('Invalid response format');
        }
        requests.add(CustomerRequestsresponse.fromJson(item));
      }
      return requests;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = CustomerRequestsresponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception('Failed to fetch requests');
    }
  }
  Future<List<CustomerRequestsresponse>> getAllRequestsProvider() async {
    Uri url = Uri.https(Apiconstants.baseUrl, Apiconstants.AllRequest);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<CustomerRequestsresponse> requests = [];

      List<dynamic> jsonResponse = json.decode(response.body);
      for (var item in jsonResponse) {
        if (item is Map<String, dynamic> && item.containsKey('image')) {
          dynamic imageData = item['image'];
          if (imageData is String) {
            Uint8List imageBytes = base64Decode(imageData);
            item['image'] = imageBytes; // Replace base64 string with Uint8List
          } else {
            throw Exception('Image data is not a string');
          }
        } else {
          throw Exception('Invalid response format');
        }
        requests.add(CustomerRequestsresponse.fromJson(item));
      }
      return requests;
    } else {
      print('RequestProvider failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = CustomerRequestsresponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception('Failed to fetch requests');
    }
  }

  Future<MakeReqResponse> makeRequest(String customerID, int catID,int id,String description,String location, Uint8List imageBytes) async {
      Uri url = Uri.https(Apiconstants.baseUrl,'/api/ServiceRequest/$customerID/$catID');
      final headers = {'Content-Type': 'application/json'};
      try {
        final response = await http.post(
          url,
          headers: headers,
          body: jsonEncode({
            'description': description,
            'location': location,
            'image': base64Encode(imageBytes),
          }),
        );

        if (response.statusCode == 200) {
          print('Image uploaded successfully');
          return MakeReqResponse.fromJson(jsonDecode(response.body));
        } else {
          print('Failed to upload image: ${response.statusCode}');
          print('Response body: ${response.body}');
          return MakeReqResponse(statusMsg: '',message: "",serviceId: 0);
        }
      } catch (e) {
        print('Error uploading image: $e');
        return MakeReqResponse(statusMsg: '',message: "",serviceId: 0);
      }
  }

  Future<UpdateServiceResponse> updateRequest(int serviceID,String description,String location, Uint8List imageBytes) async {
    Uri url = Uri.https(Apiconstants.baseUrl,'/api/ServiceRequest/$serviceID');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode({
          'description': description,
          'location': location,
          'image': base64Encode(imageBytes),
        }),
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        return UpdateServiceResponse.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to upload image: ${response.statusCode}');
        print('Response body: ${response.body}');
        return UpdateServiceResponse(statusMsg: '',message: "");
      }
    } catch (e) {
      print('Error uploading image: $e');
      return UpdateServiceResponse(statusMsg: '',message: "");
    }
  }

  Future<DeleteServiceResponse> deleteService(int serviceID) async {
    Uri url = Uri.https(Apiconstants.baseUrl, "/api/ServiceRequest/$serviceID");
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      return DeleteServiceResponse.fromJson(jsonDecode(response.body));
    } else {
      print(' DeleteService failed with status code: ${response.statusCode}');
      print(' DeleteService body: ${response.body}');
      var errorMessage = DeleteServiceResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception('DeclineOffer failed');
    }
  }

  Future<Response> timeSlot(List<DateTime> selectedDateTimeList,int serviceID) async {
    List<Map<String, dynamic>> timeSlots = selectedDateTimeList.map((dateTime) {
      TimeSlot timeSlotRequest = TimeSlot(
        date: "${dateTime.year}-${dateTime.month}-${dateTime.day}",
        fromTime: "${dateTime.hour}:${dateTime.minute}",
      );

      return timeSlotRequest.toJson();
    }).toList();
    Uri url = Uri.https(Apiconstants.baseUrl,"/api/TimeSlot/${serviceID}");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(timeSlots),
    );

    if (response.statusCode == 200) {
      return Response.fromJson(jsonDecode(response.body));
    } else {
      print('Time slot failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = Response.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception(errorMessage);
    }
  }

  Future<TimeSlot> specificTimeSlot(int timeslotID) async {
    Uri url = Uri.https(Apiconstants.baseUrl, '/api/TimeSlot/$timeslotID');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return TimeSlot.fromJson(jsonDecode(response.body));
    } else {
      print('specificTimeSlot failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = SubcategoryResponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception(errorMessage); // Throw the specific error message
    }
  }

  Future<List<OffersResponse>> getOffers(int serviceID) async {
    Uri url = Uri.https(Apiconstants.baseUrl,"/api/ServiceRequest/ServiceUndeclinedOffers/$serviceID");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable jsonList = jsonDecode(response.body);
      return List<OffersResponse>.from(jsonList.map((model) => OffersResponse.fromJson(model)));
    } else {
      print('Offers failed with status code: ${response.statusCode}');
      print('Offers body: ${response.body}');
      var errorMessage = CustomerRequestsresponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception('There is no offers');
    }
  }

  Future<AcceptOfferResponse> acceptOffer(int offerID) async {
    Uri url = Uri.https(Apiconstants.baseUrl, "/api/ServiceOffer/Accept/$offerID");
    var response = await http.put(url);

    if (response.statusCode == 200) {
      return AcceptOfferResponse.fromJson(jsonDecode(response.body));
    } else {
      print('AcceptOffer failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = AcceptOfferResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception('AcceptOffer faild');
    }
  }
  Future<DeclineOfferResponse> declineOffer(int offerID) async {
    Uri url = Uri.https(Apiconstants.baseUrl, "/api/ServiceOffer/Decline/$offerID");
    var response = await http.put(url);

    if (response.statusCode == 200) {
      return DeclineOfferResponse.fromJson(jsonDecode(response.body));
    } else {
      print('DeclineOffer failed with status code: ${response.statusCode}');
      print('DeclineOffer body: ${response.body}');
      var errorMessage = DeclineOfferResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception('DeclineOffer failed');
    }
  }

  Future<List<AllTimeSlotsResponse>> getAllTimeSlots(int serviceID) async {
    Uri url = Uri.https(Apiconstants.baseUrl, '/api/TimeSlot/service/$serviceID');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<AllTimeSlotsResponse> requests = [];
      List<dynamic> jsonResponse = json.decode(response.body);
      for (var item in jsonResponse) {

        requests.add(AllTimeSlotsResponse.fromJson(item));
      }
      return requests;
    } else {
      print('TimeSlots failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = AllTimeSlotsResponse.fromJson(jsonDecode(response.body)).id;
      print('Error message: $errorMessage');
      throw Exception('Failed to fetch requests TimeSlots');
    }
  }
  Future<ProvideOfferResponse> providerOffer(String providerID,int serviceID,int fees,int timeID,String duration) async {
    Uri url = Uri.https(Apiconstants.baseUrl,"/api/ServiceOffer/${providerID}/${serviceID}");
    var requestBody = ProviderOfferRequest(
      fees: fees,
      timeSlotId: timeID,
      duration: duration,
    );
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      return ProvideOfferResponse.fromJson(jsonDecode(response.body));
    } else {
      print('ProvideOffer failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      var errorMessage = ProvideOfferResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception(errorMessage);

    }
  }
  Future<List<OffersResponse>> getProviderOffers(String providerID) async {
    Uri url = Uri.https(Apiconstants.baseUrl,"/api/ServiceOffer/ProviderOffers/$providerID");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable jsonList = jsonDecode(response.body);
      return List<OffersResponse>.from(jsonList.map((model) => OffersResponse.fromJson(model)));
    } else {
      print('ProviderOffers with status code: ${response.statusCode}');
      print('ProviderOffers body: ${response.body}');
      var errorMessage = CustomerRequestsresponse.fromJson(jsonDecode(response.body)).description;
      print('Error message: $errorMessage');
      throw Exception('There is no Provideroffers');
    }
  }
  Future<ProvideOfferResponse> updateOffer(int offerID,int fees,int timeID,String duration) async {
    Uri url = Uri.https(Apiconstants.baseUrl,"/api/ServiceOffer/${offerID}");
    var requestBody = ProviderOfferRequest(
      fees: fees,
      timeSlotId: timeID,
      duration: duration,


    );
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      return ProvideOfferResponse.fromJson(jsonDecode(response.body));
    } else {
      print('updateOffer failed with status code: ${response.statusCode}');
      print('update offer body: ${response.body}');
      var errorMessage = ProvideOfferResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception(errorMessage);

    }
  }
  Future<DeleteServiceResponse> cancelOffer(int offerID) async {
    Uri url = Uri.https(Apiconstants.baseUrl, "/api/ServiceOffer/$offerID");
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      return DeleteServiceResponse.fromJson(jsonDecode(response.body));
    } else {
      print(' Deleteoffer failed with status code: ${response.statusCode}');
      print(' Deleteoffer body: ${response.body}');
      var errorMessage = DeleteServiceResponse.fromJson(jsonDecode(response.body)).message;
      print('Error message: $errorMessage');
      throw Exception('DeclineOffer failed');
    }
  }
}
