import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';

import '../View/MyTheme.dart';

class DropDown extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final String value;
  final bool isExpanded;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSaved;
  final List<String> items;

  DropDown({
    required this.fieldName,
    required this.hintText,
    required this.value,
    required this.isExpanded,
    required this.validator,
    this.onChanged,
    this.onSaved,
    required this.items,
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
          padding: EdgeInsets.only(top: 14, bottom: 20),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item, // Set the value to the corresponding item
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: MyTheme.primarycol, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: MyTheme.primarycol, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
////////////////////////////////////////////////////////
// class DropDowntime extends StatelessWidget {
//   final String fieldName;
//   final String hintText;
//   final String value;
//   final bool isExpanded;
//   // Updated type
//   final String? Function(String?)? onChanged;
//   final String? Function(String?)? onSaved;
//   final List<AllTimeSlotsResponse> items;
//
//   DropDowntime({
//     required this.fieldName,
//     required this.hintText,
//     required this.value,
//     required this.isExpanded, // Updated
//     this.onChanged,
//     this.onSaved,
//     required this.items,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(
//           fieldName,
//           style: Theme.of(context)
//               .textTheme
//               .titleMedium!
//               .copyWith(fontSize: 18.sp),
//           textAlign: TextAlign.start,
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 14, bottom: 20),
//           child: DropdownButtonFormField<AllTimeSlotsResponse>(
//             value: items.firstWhere((item) => item.date == value),
//             items: items.map((item) {
//               return DropdownMenuItem<AllTimeSlotsResponse>(
//                 value: item,
//                 child: Text(
//                   '${item.date} - ${item.fromTime}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               );
//             }).toList(),
//             onChanged: onChanged != null
//                 ? (AllTimeSlotsResponse? newValue) {
//               onChanged!(newValue?.date); // Pass the selected date
//             }
//                 : null,
//             onSaved: onSaved != null
//                 ? (AllTimeSlotsResponse? newValue) {
//               onSaved!(newValue?.date); // Pass the selected date
//             }
//                 : null,
//             decoration: InputDecoration(
//               fillColor: Colors.white,
//               filled: true,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: MyTheme.primarycol, width: 2.0),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: MyTheme.primarycol, width: 2.0),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: Colors.red, width: 2.0),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: Colors.red, width: 2.0),
//               ),
//               hintText: hintText,
//               hintStyle: TextStyle(color: Colors.grey),
//             ),
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }
// }

