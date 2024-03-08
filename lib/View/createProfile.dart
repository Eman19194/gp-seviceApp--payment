
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/SettingsProvider.dart';
import '../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../ViewModel/SignUP/ViewModel/SignUpScreen_ViewModel.dart';
import '../ViewModel/SignUP/ViewModel/SignUp_State.dart';
import '../utils/DrobDown.dart';
import '../utils/dialog_utils.dart';
import 'package:intl/intl.dart';
import '../utils/text_field_item.dart';
import 'MyTheme.dart';


class CreateProfile extends StatefulWidget {
  static String routeName = "CreateProfile";

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  bool hasDisability = false;
  String _selectedGenderen = 'Male';
  String _selectedGenderar = 'ذكر';
  DateTime selectedDate = DateTime.now();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _disabilityController = TextEditingController();
  TextEditingController _emergencyContactController = TextEditingController();
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();

  List<String> genderseng = ['Male', 'Female'];
  List<String> gendersear = ['ذكر', 'انثي'];

  SignUpViewMode viewModel =
  SignUpViewMode(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return BlocListener<SignUpViewMode, SignUpState>(
      bloc: viewModel,
      listener: (context, state) {
        DialogUtils.hideLoading(context);

        if (state is SignUpLoadingState) {
          DialogUtils.showLoading(context, state.loadingMsg!);
        } else if (state is SignUpErrorState) {
          DialogUtils.showMessage(
            context,
            state.errorMsg!,
            posActionName: "Ok",
            title: "Error",
          );
        } else if (state is SignUpSuccessState) {
          DialogUtils.showMessage(
            context,
            state.response.message?.toString() ?? "",
            posActionName: 'Ok',
            title: "Successful",
          );
          Navigator.pushNamed(context, CreateProfile.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.createProfile),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 250,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.letEnterData,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldItem(
                                fieldName: AppLocalizations.of(context)!.firstName,
                                hintText: AppLocalizations.of(context)!.enterFirstName,
                                controller: _fNameController,
                                validator: (value) {
                                  // Your validation logic here
                                },
                              ),
                              TextFieldItem(
                                fieldName: AppLocalizations.of(context)!.lastName,
                                hintText: AppLocalizations.of(context)!.enterLastName,
                                controller: _lNameController,
                                validator: (value) {
                                  // Your validation logic here
                                },
                              ),
                              DropDown(
                                isExpanded: true,
                                fieldName: AppLocalizations.of(context)!.gender,
                                hintText: AppLocalizations.of(context)!.selectGender,
                                items: settingsProvider.currentLocale == 'en'
                                    ? genderseng
                                    : gendersear,
                                value: settingsProvider.currentLocale == 'en'
                                    ?_selectedGenderen
                                    :_selectedGenderar,
                                onChanged: (value) {
                                  setState(() {
                                    if(settingsProvider.currentLocale == 'en'){
                                      _selectedGenderen = value.toString();
                                    }else{
                                      _selectedGenderar = value.toString();
                                    }

                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return settingsProvider.currentLocale == 'en'
                                        ? 'Please select your gender'
                                        : 'برجاء ادخال النوع ';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  AppLocalizations.of(context)!.selectbirthday,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only( bottom: 20.h),
                                height: 64,
                                width: 398,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: MyTheme.primarycol, // Border color
                                    width: 2.0,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showDatePicker(

                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now().add(Duration(days: 365)),
                                    ).then((pickedDate) {
                                      if (pickedDate != null) {
                                        setState(() {
                                          selectedDate = pickedDate;
                                          _birthDateController.text =
                                              DateFormat('yyyy-MM-dd').format(selectedDate);
                                        });
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Text(
                                      DateFormat('yyyy-MM-dd').format(selectedDate),
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                              ),
                              TextFieldItem(
                                fieldName: AppLocalizations.of(context)!.emergContact,
                                hintText: AppLocalizations.of(context)!.enterEmergContact,
                                controller: _emergencyContactController,
                                validator: (value) {
                                  // Your validation logic here
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.country,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              CountryStateCityPicker(
                                country: country,
                                state: state,
                                city: city,
                                dialogColor: Colors.white,
                                textFieldDecoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusColor: MyTheme.primarycol,
                                  filled: true,
                                  suffixIcon: Icon(Icons.arrow_drop_down_circle_outlined, color: MyTheme.primarycol,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(color: MyTheme.primarycol, width: 2.0), // Set the border color to green
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              TextFieldItem(
                                fieldName: AppLocalizations.of(context)!.address,
                                hintText: AppLocalizations.of(context)!.enterAddress,
                                controller: _addressController,
                                validator: (value) {
                                  // Text("${country.text}, ${state.text}, ${city.text}")
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: MyTheme.primarycol, width: 2.0), // Outline color
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Padding(
                                  padding:EdgeInsets.all(8.h),
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.haveDisability,
                                        style: TextStyle(color: Colors.blueGrey),),
                                      Switch(
                                        value: hasDisability,
                                        onChanged: (value) {
                                          setState(() {
                                            hasDisability = value;
                                          });
                                        },
                                        activeColor: MyTheme.primarycol,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Visibility(
                                visible: hasDisability,
                                child: TextFieldItem(
                                  fieldName: AppLocalizations.of(context)!.disability,
                                  hintText: AppLocalizations.of(context)!.enterDisability,
                                  controller: _disabilityController,
                                  validator: (value) {
                                    // Your validation logic here
                                  },
                                ),
                              ),




                              SizedBox(height: 16),
                              Padding(
                                padding: EdgeInsets.only(top: 35, bottom: 45),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Your button press logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyTheme.primarycol,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  child: Container(
                                    height: 64,
                                    width: 398,
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.createProfile,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(color: MyTheme.backgroundLight, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
