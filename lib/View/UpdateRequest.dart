import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/ViewModel/Requests/UpdateRequestVM.dart';
import 'package:gp/utils/dialog_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart'as loc;
import '../utils/text_field_item.dart';
import 'MyTheme.dart';

class UpdateRequest extends StatefulWidget {
  static String routeName = "update";
  final int serviceID;
  final int index;
  final String? title;
  final String? location;
  final Uint8List? image;
  Position? position;

  UpdateRequest({
    required this.serviceID,
    required this.index,
    required this.title,
    required this.location,
    required this.image,
  });

  @override
  _UpdateRequestState createState() => _UpdateRequestState();
}

class _UpdateRequestState extends State<UpdateRequest> {
  late TextEditingController _descriptionController;
  List<File> _images = [];
  late Uint8List _selectedImage;
  late String? selectedLocation;
  Position? position;
  UpdateRequestVM viewModel = UpdateRequestVM(inJectAuthRepoContract());
  @override
  void initState() {
    super.initState();
    // Initialize text controllers with initial values
    _descriptionController = TextEditingController(text: widget.title);
    selectedLocation = widget.location!;
    _selectedImage = widget.image!;
  }

  @override
  void dispose() {
    // Dispose text controllers
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateRequestVM, UpdateRequestStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is UpdateRequestLoadingState) {
          DialogUtils.showLoading(context, state.loadingMessage!);
        } else if (state is UpdateRequestErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: "Ok", title: "error");
        } else if (state is UpdateRequestSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            state.response.message?.toString() ?? "",
            posActionName: 'Ok',
            title: "sucessfull",
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.update_request),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.serviceID,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.primarycol),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.index.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 8),
                TextFieldItem(
                  controller: _descriptionController,
                  fieldName: AppLocalizations.of(context)!.description,
                  hintText: _descriptionController.text,
                ),
                SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.image,
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            MemoryImage(_selectedImage),
                                        // FileImage(_images[index]),
                                        radius: 40,
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
                                        backgroundImage:
                                            MemoryImage(_selectedImage),
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
                SizedBox(height: 8),
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
                                    _chechServiceEnable();
                                    await _determinePosition();
                                    print("Location>>>>${selectedLocation}");
                                  },
                                  child: Icon(
                                    Icons.location_on,
                                    color: MyTheme.primarycol,
                                  ),
                                ),
                                SizedBox(width: 8), // Add some spacing between the icon and the text
                                Expanded(
                                  child: Text(selectedLocation!),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: ElevatedButton(
                    onPressed: () async {
                      await viewModel.updateRequest(widget.serviceID,_descriptionController.text, selectedLocation!, _selectedImage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.primarycol,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      ),
                    ),
                    child: Container(
                      height: 60.h,
                      width: 398.w,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.update_request,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            color: MyTheme.backgroundLight,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

    XFile? image = await ImagePicker().pickImage(source:imageSource);

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

  Future<bool> _chechServiceEnable() async {
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
