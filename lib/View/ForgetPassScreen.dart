import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/View/ValidateCodeScreen.dart';
import 'package:gp/ViewModel/ForgetPassword/ForgetPassStates.dart';
import 'package:gp/ViewModel/ForgetPassword/ForgetPassVM.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/dialog_utils.dart';
import '../utils/text_field_item.dart';
import 'MyTheme.dart';
import 'ResetPasswordScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = 'PassScreen';
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  ForgetPassVM viewModel = ForgetPassVM(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPassVM, ForgetPasswordStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ForgetPasswordLoadingState) {
          DialogUtils.showLoading(context, state.loadingMessage!);
        } else if (state is ForgetPasswordErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: "Ok", title: "error");
        } else if (state is ForgetPasswordSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            state.response.message?.toString() ?? "",
            posActionName: 'Ok',
            title: "successful",
          );
          Navigator.pushNamed(context, ValidateCodeScreen.routeName,arguments: state.response.code);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.forgetPassword),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        hintText:
                        AppLocalizations.of(context)!.enterEmail,
                        controller: viewModel.emailController,
                        validator: (value) {
                          return viewModel.validateEmail(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: ElevatedButton(
                  onPressed: () async {
                    await viewModel.forgetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.primarycol,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15.r)),
                    ),
                  ),
                  child: Container(
                    height: 60.h,
                    width: 398.w,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.forgetPassword,
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
              SizedBox(
                width: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes when not needed
    _emailController.dispose();

    super.dispose();
  }

}
