import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../View/MyTheme.dart';
class DateTimePicker extends StatefulWidget {
  List<DateTime> selectedDateTimeList;
  DateTimePicker({required this.selectedDateTimeList});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  void initState() {
    super.initState();
    // Add a default DateTime to the list if it's empty
    if (widget.selectedDateTimeList.isEmpty) {
      widget.selectedDateTimeList.add(DateTime.now());
    }
  }

  void addDateTimePicker() {
    if (widget.selectedDateTimeList.length < 3) {
      setState(() {
        widget.selectedDateTimeList.add(DateTime.now());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Maximum 3 time slots allowed'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int index = 0; index < widget.selectedDateTimeList.length; index++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Time", // Label for the time selection field
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: MyTheme.primarycol),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: InkWell(
                  onTap: () async {
                    DateTime? dateTime = await showOmniDateTimePicker(
                      context: context,
                      initialDate: widget.selectedDateTimeList[index],
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 3652)),
                      is24HourMode: false,
                      isShowSeconds: false,
                      minutesInterval: 1,
                      secondsInterval: 1,
                      isForce2Digits: true,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      constraints: const BoxConstraints(
                        maxWidth: 350,
                        maxHeight: 650,
                      ),
                      transitionBuilder: (context, anim1, anim2, child) {
                        return FadeTransition(
                          opacity: anim1.drive(
                            Tween(
                              begin: 0,
                              end: 1,
                            ),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      selectableDayPredicate: (dateTime) {
                        // Disable past dates
                        return dateTime.isAfter(DateTime.now().subtract(Duration(days: 1)));
                      },
                    );

                    if (dateTime != null) {
                      setState(() {
                        widget.selectedDateTimeList[index] = dateTime;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, color: MyTheme.primarycol),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${widget.selectedDateTimeList[index].year}-${widget.selectedDateTimeList[index].month}-${widget.selectedDateTimeList[index].day}-${widget.selectedDateTimeList[index].hour}:${widget.selectedDateTimeList[index].minute}",
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        if (widget.selectedDateTimeList.length < 3)
          // Only show the "Add" button if there are less than 3 date-time picker fields
          SizedBox(
            width: 100, // Set a specific width for the button
            child: ElevatedButton(
              onPressed: addDateTimePicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4), // Adjust spacing between icon and text
                  Text('Add', style: TextStyle(fontSize: 12)), // Make the text smaller
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// class DateTimePicker extends StatefulWidget {
//   List<DateTime> selectedDateTimeList;
//   DateTimePicker({required this.selectedDateTimeList});
//
//   @override
//   State<DateTimePicker> createState() => _DateTimePickerState();
// }
//
// class _DateTimePickerState extends State<DateTimePicker> {
//   void addDateTimePicker() {
//     if (widget.selectedDateTimeList.length < 3) {
//       setState(() {
//         widget.selectedDateTimeList.add(DateTime.now());
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Maximum 3 time slots allowed'),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (int index = 0; index < widget.selectedDateTimeList.length; index++)
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Enter Time", // Label for the time selection field
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: MyTheme.primarycol),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: InkWell(
//                   onTap: () async {
//                     DateTime? dateTime = await showOmniDateTimePicker(
//                       context: context,
//                       initialDate: widget.selectedDateTimeList[index],
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime.now().add(const Duration(days: 3652)),
//                       is24HourMode: false,
//                       isShowSeconds: false,
//                       minutesInterval: 1,
//                       secondsInterval: 1,
//                       isForce2Digits: true,
//                       borderRadius: const BorderRadius.all(Radius.circular(16)),
//                       constraints: const BoxConstraints(
//                         maxWidth: 350,
//                         maxHeight: 650,
//                       ),
//                       transitionBuilder: (context, anim1, anim2, child) {
//                         return FadeTransition(
//                           opacity: anim1.drive(
//                             Tween(
//                               begin: 0,
//                               end: 1,
//                             ),
//                           ),
//                           child: child,
//                         );
//                       },
//                       transitionDuration: const Duration(milliseconds: 200),
//                       barrierDismissible: true,
//                       selectableDayPredicate: (dateTime) {
//                         // Disable past dates
//                         return dateTime.isAfter(DateTime.now().subtract(Duration(days: 1)));
//                       },
//                     );
//
//                     if (dateTime != null) {
//                       setState(() {
//                         widget.selectedDateTimeList[index] = dateTime;
//                       });
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.calendar_today, color: MyTheme.primarycol),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             "${widget.selectedDateTimeList[index].year}-${widget.selectedDateTimeList[index].month}-${widget.selectedDateTimeList[index].day}-${widget.selectedDateTimeList[index].hour}:${widget.selectedDateTimeList[index].minute}",
//                             style: TextStyle(color: Colors.black),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         if (widget.selectedDateTimeList.length < 3) // Only show the "Add" button if there are less than 3 date-time picker fields
//           SizedBox(
//             width: 100, // Set a specific width for the button
//             child: ElevatedButton(
//               onPressed: addDateTimePicker,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.add),
//                   SizedBox(width: 4), // Adjust spacing between icon and text
//                   Text('Add', style: TextStyle(fontSize: 12)), // Make the text smaller
//                 ],
//               ),
//             ),
//           ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }



