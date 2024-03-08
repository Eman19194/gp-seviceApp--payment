import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/View/HomeScreen.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/View/createProfile.dart';
import '../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../ViewModel/SignUP/ViewModel/SignUpScreen_ViewModel.dart';
import '../ViewModel/SignUP/ViewModel/SignUp_State.dart';
import '../utils/dialog_utils.dart';
import '../utils/text_field_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
    SignUpViewMode viewModel= SignUpViewMode(inJectAuthRepoContract());
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpViewMode, SignUpState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          DialogUtils.showLoading(context, state.loadingMsg!);
        } else if (state is SignUpErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMsg!,
              posActionName: "Ok", title: "error");
        } else if (state is SignUpSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            state.response.message?.toString() ?? "",
            posActionName: 'Ok',
            title: "sucessfull",
          );
          print("signUp ID: ${state.response.userId}");
          Navigator.pushNamed(context, HomeScreen.routeName, arguments:  state.response.userId);
        }
      },
      child:Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.letSignUp,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: viewModel.formKey,
                          child: Column(
                            children: [
                              TextFieldItem(
                                fieldName: AppLocalizations.of(context)!.email,
                                hintText: AppLocalizations.of(context)!.enterEmail,
                                controller: viewModel.emailController,
                                validator: (value) {
                                  return viewModel.validateEmail(value!);
                                },
                              ),
                              TextFieldItem(
                                fieldName: AppLocalizations.of(context)!.password,
                                hintText: AppLocalizations.of(context)!.enterPassword,
                                controller: viewModel.passwordController,
                                validator: (value) {
                                  return viewModel.validatePassword(value!);
                                },
                                isObscure: viewModel.isObscure,
                                suffixIcon: InkWell(
                                  child: viewModel.isObscure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onTap: () {
                                    setState(() {
                                      viewModel.isObscure = !viewModel.isObscure;
                                    });
                                  },
                                ),
                              ),
                              TextFieldItem(
                                fieldName: AppLocalizations.of(context)!.confirmationPassword,
                                hintText: AppLocalizations.of(context)!.enterConfirmPass,
                                controller: viewModel.confirmPasswordController,
                                validator: (value) {
                                  return viewModel.validateConfirmPassword(value!);
                                },
                                isObscure: viewModel.isObscure,
                                suffixIcon: InkWell(
                                  child: viewModel.isObscure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onTap: () {
                                    setState(() {
                                      viewModel.isObscure = !viewModel.isObscure;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25.h),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                            });
                            await viewModel.signUp();


                          },

                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.primarycol,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.r)))),
                          child: Container(
                            height: 64.h,
                            width: 398.w,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.signup,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    color: MyTheme.backgroundLight,
                                    fontSize: 20.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h,bottom:30.h ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.already_have_acc,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context); // Navigate back to login
                              },
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style:TextStyle(color: MyTheme.primarycol,fontSize: 22),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}

