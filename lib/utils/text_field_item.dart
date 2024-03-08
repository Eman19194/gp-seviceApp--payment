import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/View/MyTheme.dart';

class TextFieldItem extends StatelessWidget {
  String fieldName;
  String hintText;
  Widget? suffixIcon;
  bool isObscure;
  var keyboardType;
  String? Function(String?)? validator;
  TextEditingController controller;
  void Function(String)? onSubmitted; // Function to be called when submitted

  TextFieldItem({
    required this.fieldName,
    required this.hintText,
    this.suffixIcon,
    this.isObscure = false,
    this.validator,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted, // Pass the onSubmitted function as an argument
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          fieldName,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 18.sp),
          textAlign: TextAlign.start,
        ),
        Padding(
          padding: EdgeInsets.only(top: 14.h, bottom: 20.h),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: MyTheme.primarycol, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: MyTheme.primarycol, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.grey),
              suffixIcon: suffixIcon,
            ),
            style: const TextStyle(color: Colors.black),
            validator: validator,
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
            onFieldSubmitted: onSubmitted, // Assign the onSubmitted function to onFieldSubmitted
          ),
        )
      ],
    );
  }
}
