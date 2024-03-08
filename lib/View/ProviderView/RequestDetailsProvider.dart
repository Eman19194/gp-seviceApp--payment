import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/View/ProviderView/MakeOffer.dart';
import '../MyTheme.dart';


class RequestDetailsProvider extends StatelessWidget {
  final int index;
  final String? title;
  final String? location;
  final Uint8List? image;
  final int serviceID;
  final List<AllTimeSlotsResponse> timeslots;
  String providerID="";

  RequestDetailsProvider(
      this.providerID,
      this.index,
      this.title,
      this.location,
      this.image,
      this.serviceID,
      this.timeslots,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.request_details),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.serviceID,
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
                  serviceID.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
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
                  title!,
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
                  location!, // Display the location data
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
                    borderRadius: BorderRadius.circular(8), // Same as container's border radius
                    child: Image.memory(
                      image!,
                      fit: BoxFit.fill, // Adjust the image to cover the entire area
                      width: 60, // Set width to fit the container
                      height: 120, // Set height to fit the container
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
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
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProviderOffer(
                                providerID,
                                title,location,image,serviceID,timeslots
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              MyTheme.primarycol),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.makeOffer,
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
      ),
    );
  }
}
