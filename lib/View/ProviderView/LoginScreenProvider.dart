import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/View/ForgetPassScreen.dart';
import 'package:gp/View/HomeScreen.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/View/ProviderView/HomeScreenProvider.dart';
import 'package:gp/View/ProviderView/SignUpScreenProvider.dart';
import 'package:gp/View/SignUpScreen.dart';
import 'package:gp/utils/dialog_utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../../ViewModel/Login/ViewModel/LoginState.dart';
import '../../ViewModel/Login/ViewModel/LoginViewModel.dart';
import '../../utils/text_field_item.dart';


class LoginScreenProvider extends StatefulWidget {
  static const String routeName = 'loginScreenP';

  @override
  State<LoginScreenProvider> createState() => _LoginScreenProviderState();
}

class _LoginScreenProviderState extends State<LoginScreenProvider> {
  LoginScreenViewModel viewModel = LoginScreenViewModel(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenViewModel, LoginStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          DialogUtils.showLoading(context, state.loadingMessage!);
        } else if (state is LoginErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: "Ok", title: "error");
        } else if (state is LoginSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            state.response.message?.toString() ?? "",
            posActionName: 'Ok',
            title: "sucessfull",
          );
          String token =state.response.token.toString();
          String? nameIdentifier=viewModel.extractNameIdentifierFromToken(token);
          Navigator.pushNamed(context, HomeScreenProvider.routeName, arguments:  nameIdentifier);
        }
      },
      child: Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.letsLogin,
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: ElevatedButton(
                          onPressed: () async {
                            await viewModel.login();
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
                                AppLocalizations.of(context)!.login,
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
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgetPassword,
                              style: TextStyle(color: MyTheme.primarycol, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dontHaveAcc,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SignUpScreenProvider.routeName);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signup,
                                style: TextStyle(color: MyTheme.primarycol, fontSize: 22),
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
      ),
    );
  }
}
