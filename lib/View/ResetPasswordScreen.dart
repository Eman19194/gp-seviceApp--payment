import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/ViewModel/ForgetPassword/ResetPassStates.dart';
import 'package:gp/ViewModel/ForgetPassword/ResstPassVM.dart';
import '../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../ViewModel/SignUP/ViewModel/SignUpScreen_ViewModel.dart';
import '../utils/dialog_utils.dart';
import '../utils/text_field_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName="resetPass";
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPassVM viewModel= ResetPassVM(inJectAuthRepoContract());
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPassVM, ResetPasswordStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          DialogUtils.showLoading(context, state.loadingMessage!);
        } else if (state is ResetPasswordErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: "Ok", title: "error");
        } else if (state is ResetPasswordSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            state.response.message?.toString() ?? "",
            posActionName: 'Ok',
            title: "sucessfull",
          );
        }
      },
      child:Scaffold(
        appBar: AppBar(

        ),
        body: Container(
          margin: EdgeInsets.all(10),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

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
                            await viewModel.resetPassword();


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
                                AppLocalizations.of(context)!.resetPassword,
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



