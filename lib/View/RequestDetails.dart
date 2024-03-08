import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/View/RequestsTab.dart';
import 'package:gp/View/UpdateRequest.dart';
import 'package:gp/ViewModel/TimeSlot/TimeSlotsVM.dart';
import '../ViewModel/Requests/DeleteServiceVM.dart';
import 'MyTheme.dart';

class RequestDetails extends StatefulWidget {
  final int index;
  final String userId;
  final String? title;
  final String? location;
  final String? status;
  final Uint8List? image;
  final int serviceID;

  RequestDetails(this.userId, this.index, this.title, this.location, this.image, this.status, this.serviceID);

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  List<AllTimeSlotsResponse> timeslots=[];
  late DeleteServiceVM viewModel;
  late TimeSlotsVM viewModelTime;

  @override
  void initState() {
    super.initState();
    viewModel = DeleteServiceVM(inJectAuthRepoContract());
    viewModelTime = TimeSlotsVM(inJectAuthRepoContract());
    fetchTimeSlots();
  }

  Future<void> fetchTimeSlots() async {
    timeslots = await viewModelTime.getAllTimeSlots(widget.serviceID);
    setState(() {}); // Update the UI after fetching timeslots
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.request_details),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.description,
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
                widget.title!,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.location,
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
                widget.location!, // Display the location data
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.image,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.primarycol),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    widget.image!,
                    fit: BoxFit.fill,
                    width: 60,
                    height: 120,
                  ),
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.timeSlot,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Displaying timeslots using ListView.builder
            ListView.builder(
              shrinkWrap: true,
              itemCount: timeslots.length,
              itemBuilder: (context, index) {
                final timeSlot = timeslots[index];
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.primarycol),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${timeSlot.date} ${timeSlot.fromTime}',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(
                        10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateRequest(
                              serviceID:widget.serviceID,
                              index: widget.index,
                              title: widget.title,
                              location: widget.location,
                              image: widget.image,
                            ),
                          ),
                        );

                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            MyTheme.primarycol),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        print(widget.serviceID);
                        viewModel.deleteService(widget.serviceID);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(AppLocalizations.of(context)!.confirmCancel),
                              content:Text(
                                AppLocalizations.of(context)!.cancelreq,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                  },
                                  child: Text(AppLocalizations.of(context)!.no),
                                ),
                                TextButton(
                                  onPressed: () {
                                    viewModel.deleteService(widget.serviceID);
                                  },
                                  child: Text(AppLocalizations.of(context)!.yes),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}