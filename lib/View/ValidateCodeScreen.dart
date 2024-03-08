import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/View/ResetPasswordScreen.dart';
import 'package:gp/ViewModel/ForgetPassword/ForgetPassVM.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'MyTheme.dart';


class ValidateCodeScreen extends StatefulWidget {
  static const String routeName = 'ValidateCodeScreen';

  @override
  _ValidateCodeScreenState createState() => _ValidateCodeScreenState();
}

class _ValidateCodeScreenState extends State<ValidateCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String code="";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is String) {
      code = arguments;
    } else {
      code = ""; // Default value
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.validateCode),
        backgroundColor: Color(0xffefeeee),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                elevation: 2.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.enterCode,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: ElevatedButton(
                          onPressed: () {
                            if(code == _codeController.text) {
                              Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)!.invalidCode),
                                    content: Text(AppLocalizations.of(context)!.theenteredcodeisincorrect),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(AppLocalizations.of(context)!.oK),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
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
                                AppLocalizations.of(context)!.validate,
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
