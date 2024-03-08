import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gp/Model/data/model/MakeReqResponse.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/View/OffersScreen.dart';
import 'package:gp/ViewModel/Requests/MakeRequestStates.dart';
import 'package:gp/ViewModel/Requests/MakeRequestVM.dart';
import 'package:gp/ViewModel/TimeSlot/TimeSlotVM.dart';
import 'package:location/location.dart'as loc;
import '../Model/data/model/CategoryResponse.dart';
import '../Model/data/model/SubcategoryResponse.dart';
import '../ViewModel/Categories/AllCategoriesVM.dart';
import '../ViewModel/Subcategories/AllSubategoriesVM.dart';
import '../utils/dateTimePicker.dart';
import '../utils/dialog_utils.dart';
import '../utils/text_field_item.dart';
import 'MyTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MakeRequest extends StatefulWidget {
  static String routeName = "MakeRequest";

  @override
  State<MakeRequest> createState() => _MakeRequestState();
}

class _MakeRequestState extends State<MakeRequest> {
  var userId;
  List<CategoryResponse> categories = [];
  CategoryResponse selectedCategory = CategoryResponse(id: 0, name: "", description: "");
  List<SubcategoryResponse> subcategories = [];
  SubcategoryResponse? selectedSubcategory = SubcategoryResponse(id: 0, name: "", description: "");
  List<File> _images = [];
  Uint8List _selectedImage = Uint8List(0);

  DateTime selectedDate = DateTime.now();
  DateTime? selectedDateTime;
  String date ="YYYY-MM-DD";
  String time = "00:00";

  // TextEditingController categoryIDController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String selectedLocation = "click to Enter Location";
  Position? position;
  MakeRequestViewModel viewModel = MakeRequestViewModel(inJectAuthRepoContract());
  TimeSlotVM viewModeltimeSlot = TimeSlotVM(inJectAuthRepoContract());
  AllCategoriesVM categoriesVM = AllCategoriesVM(inJectAuthRepoContract());
  AllSubcategoriesVM subcategoriesVM = AllSubcategoriesVM(inJectAuthRepoContract());
  List<DateTime> selectedDateTimeList = [];

  @override
  void initState(){
    super.initState();
    categoriesVM.getAllCategories().then((response) {
      categories = response.data;
      if (categories.isNotEmpty) {
        setState(() {
          selectedCategory = categories[0];
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is String) {
      userId = arguments;
    } else {
      userId = ""; // Default value
    }
    return BlocListener<MakeRequestViewModel, MakeRequestStates>(
        bloc: viewModel,
        listener: (context, state) {
      if (state is MakeRequestLoadingState) {
        DialogUtils.showLoading(context, state.loadingMessage!);
      } else if (state is MakeRequestErrorState) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, state.errorMessage!,
            posActionName: "Ok", title: "error");
      } else if (state is MakeRequestSuccessState) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          state.response.message?.toString() ?? "",
          posActionName: 'Ok',
          title: "Success",
          posAction: () {
            Navigator.pop(context);
          },
        );
      }
    },

    child:Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.make_new_request),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(AppLocalizations.of(context)!.category,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                      SizedBox(width: 60),
                      Expanded(
                        child: DropdownButton<CategoryResponse>(
                          value: selectedCategory,
                          onChanged: (CategoryResponse? newValue) {
                            setState(() {
                              selectedCategory = newValue!;
                              // Update subcategories based on the selected category
                              categoriesVM.getAllCategories().then((response) {
                                categories = response.data;
                                if (categories.isNotEmpty) {
                                  setState(() {
                                    selectedCategory = categories[0];
                                  });
                                }
                              });
                              subcategoriesVM.getAllSubcategories(selectedCategory.id!).then((response) {
                                subcategories = response.data;
                                if (subcategories.isNotEmpty) {
                                  setState(() {
                                    selectedSubcategory = subcategories[0];
                                  });
                                }
                              });
                            });
                          },
                          items: categories.map<DropdownMenuItem<CategoryResponse>>(
                                (CategoryResponse category) {
                              return DropdownMenuItem<CategoryResponse>(
                                value: category,
                                child: Text(category.name!),
                              );
                            },
                          ).toList(),
                        ),
                      ),]),
                  Row(
                      children: [
                        Text(AppLocalizations.of(context)!.subCategory,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                        SizedBox(width: 20),
                        Expanded(
                          child: DropdownButton<SubcategoryResponse>(
                            value: selectedSubcategory,
                            onChanged: (SubcategoryResponse? newValue) {
                              setState(() {
                                selectedSubcategory = newValue!;
                              });
                            },
                            items: subcategories.map<DropdownMenuItem<SubcategoryResponse>>(
                                  (SubcategoryResponse subcategory) {
                                return DropdownMenuItem<SubcategoryResponse>(
                                  value: subcategory,
                                  child: Text(subcategory.name!),
                                );
                              },
                            ).toList(),
                          ),
                        ),]),
                  TextFieldItem(
                    fieldName: AppLocalizations.of(context)!.enterDescription,
                    hintText: AppLocalizations.of(context)!.description,
                    controller: viewModel.discriptionController,
                    validator: (value) {
                      // Your validation logic here
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.image,
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Display selected images in a horizontal ListView
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await _showImagePickerDialog();

                            } catch (e) {
                              print("Error: $e");
                              // Handle error
                            }
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.primarycol),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: _images.isEmpty
                                ? Center(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt,
                                      size: 40,
                                      color: MyTheme.primarycol),
                                  Text(
                                    AppLocalizations.of(context)!.uploadImage,
                                    style: TextStyle(
                                        color: MyTheme.primarycol),
                                  ),
                                ],
                              ),
                            )
                                : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: MemoryImage(
                                        _selectedImage),
                                    // FileImage(_images[index]),
                                    radius: 40,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  DateTimePicker(selectedDateTimeList: selectedDateTimeList,),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.location,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.primarycol),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      _checkServiceEnable();
                                      await _determinePosition();
                                      print("Location>>>>${selectedLocation}");
                                      viewModel.selectedLocation = selectedLocation;
                                    },
                                    child: Icon(
                                      Icons.location_on,
                                      color: MyTheme.primarycol,
                                    ),
                                  ),
                                  SizedBox(width: 8), // Add some spacing between the icon and the text
                                  Expanded(
                                    child: Text(
                                      position == null ? "Click to Enter Location" : selectedLocation,
                                      // Remove TextOverflow.ellipsis to display the entire location text
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () async {
                        // int catID= viewModel.convertCatId(categoryIDController);
                        // "fb04c549-a3b1-4f8a-85ce-7ce390bb883c"
                        int? subcatID = selectedSubcategory?.id;
                        MakeReqResponse re=await viewModel.makeRequest(userId, subcatID!, _selectedImage);
                        int? serviceID=re.serviceId;
                        await viewModeltimeSlot.timeSlot(selectedDateTimeList, serviceID!);
                        Navigator.pushNamed(context, OffersScreen.routeName,arguments: serviceID);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.primarycol,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)))),
                      child: Container(
                        height: 60,
                        width: 398,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.make_new_request,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
  Future<void> _showImagePickerDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectImageSource),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.photo_library),
                      SizedBox(width: 10),
                      Text(AppLocalizations.of(context)!.pickfromGallery),
                    ],
                  ),
                  onTap: () async {
                    try {
                      Uint8List selectedImagesString = await pickImages(ImageSource.gallery);
                      setState(() {
                        _selectedImage= selectedImagesString;
                      });
                    } catch (e) {
                      print("Error: $e");
                      // Handle error
                    }
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text(AppLocalizations.of(context)!.takeaPhoto),
                    ],
                  ),
                  onTap: () async {
                    try {
                      Uint8List selectedImagesString = await pickImages(ImageSource.camera);
                      setState(() {
                        _selectedImage= selectedImagesString;
                      });
                    } catch (e) {
                      print("Error: $e");
                      // Handle error
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Uint8List> pickImages(ImageSource imageSource) async {
    Completer<Uint8List> completer = Completer<Uint8List>();
    XFile? image = await ImagePicker().pickImage(source: imageSource);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _images = [File(image.path)];
        print("Selected image: $_images");
      });
      completer.complete(imageBytes);
    } else {
      completer.completeError("No image selected");
    }
    return completer.future;
  }


  Future<bool> _checkServiceEnable() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    loc.Location location = loc.Location();
    if (!serviceEnabled) {
      bool requestService = await location.requestService();
      if (requestService) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<void> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
    position = await Geolocator.getCurrentPosition();
    List<Placemark>places =await placemarkFromCoordinates(position?.latitude??0, position?.longitude??0);
    setState(() {});
    if (position != null) {
      setState(() {
        selectedLocation = "${places[0].administrativeArea}- ${places[0].subAdministrativeArea}-${places[0].street}";
      });
    }
  }
}

