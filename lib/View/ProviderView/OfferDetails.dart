import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/View/ProviderView/MakeOffer.dart';
import 'package:gp/View/ProviderView/UpdateOffer.dart';
import 'package:gp/ViewModel/Requests/DeleteServiceVM.dart';
import '../../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../MyTheme.dart';


class OffersDetails extends StatelessWidget {
  static const String routeName="OffersDetails";
  final int id;
  final int fees;
  final int timeSlotId;
  final String? duration;
  final String? status;
  // final List<AllTimeSlotsResponse> timeslots;


  OffersDetails(
      this.id,
      this.fees,
      this.timeSlotId,
      this.duration,
      this.status,
      // this.timeslots
      );
  DeleteServiceVM viewModel=DeleteServiceVM(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.offerDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.offerID,
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
                  id.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.status,
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
                  status!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.fees,
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
                  "${fees}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.timeID,
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
                  "${timeSlotId}", // Display the location data
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.selectedDuration,
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
                  duration!, // Display the location data
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Visibility(
                visible: status == "Offered" || status == "Decline",
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateOffer(duration,id,fees,timeSlotId),
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
                            AppLocalizations.of(context)!.update,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:  Text(AppLocalizations.of(context)!.confirmCancel),
                                  content: Text(
                                    AppLocalizations.of(context)!.qCancelOffer,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.pop(context);
                                      },
                                      child: Text(AppLocalizations.of(context)!.no),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        viewModel.cancelOffer(id);

                                      },
                                      child: Text(AppLocalizations.of(context)!.yes),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          // onPressed: () async {
                          //   viewModel.cancelOffer(id);
                          // },
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

              ),

            ],
          ),
        ),
      ),
    );
  }
}
