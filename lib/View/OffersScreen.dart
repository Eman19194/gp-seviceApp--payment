import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/Model/data/model/TimeSlot.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/ViewModel/Offers/AcceptOfferVM.dart';
import 'package:gp/ViewModel/Offers/DeclineOfferVM.dart';
import 'package:gp/ViewModel/Offers/OffersVM.dart';
import 'package:gp/ViewModel/TimeSlot/SpecificTimeslotVM.dart';

import '../Model/data/model/OffersResponse.dart';

class OffersScreen extends StatefulWidget {
  static String routeName = "Offers";

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final OffersVM viewModel = OffersVM(inJectAuthRepoContract());
  final AcceptOfferVM viewModelAccept = AcceptOfferVM(inJectAuthRepoContract());
  final DeclineOfferVM viewModelDecline = DeclineOfferVM(inJectAuthRepoContract());
  final SpecificTimeSlotVM viewModelTimeslot = SpecificTimeSlotVM(inJectAuthRepoContract());

  late List<OffersResponse> data;
  late TimeSlot timeslot = TimeSlot();
  int serviceID = 0;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is int) {
      serviceID = arguments;
    }
    return Scaffold(
      backgroundColor: Color(0xffefefef),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.offers),
      ),
      body: FutureBuilder<List<OffersResponse>>(
        future: viewModel.getOffers(serviceID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display loading indicator while fetching data
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Display error message if data fetching fails
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            // Set the fetched data to the data list
            data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                int? id = data[index].id;
                return _buildTile(index, id, data[index]);
              },
            );
          } else {
            // Display a message when there's no data
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
  Widget _buildTile(int index, int? id, OffersResponse offer) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                  '${AppLocalizations.of(context)!.offer} #${offer.id}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),),
                  Text(
                    offer.fees.toString() + " EGP",
                      style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.grey[600],
                    ),),
                ],),
              SizedBox(height: 10.h),
              FutureBuilder<TimeSlot>(
                future: viewModelTimeslot.getSpecificTimeSlot(offer.timeSlotId ?? 0),
                builder: (context, snapshot) {
                  timeslot = snapshot.data?? TimeSlot();
                  return Row(
                    children: [
                      Icon(Icons.calendar_month, color: MyTheme.primarycol),
                    SizedBox(width: 5.w),
                      Text(
                        '${timeslot.date ?? 'Not Determined'}',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${timeslot.fromTime ?? 'Not Determined'}',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  );
                }
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.lock_clock, color: MyTheme.primarycol),
                  SizedBox(width: 5.w),
                  Text(
                    '${AppLocalizations.of(context)!.offer}: ${offer.duration ?? 'Not Determined'}',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              offer.status == "Accepted" ? Center(child: Text("Accepted"))
              :  Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        print('Accepted item with ID $id at index $index');
                        await viewModelAccept.acceptOffer(id!);
                        setState(() {});
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
                        AppLocalizations.of(context)!.accept,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        print('Declined item with ID $id at index $index');
                        await viewModelDecline.declineOffer(id!);
                        setState(() {});
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
                        AppLocalizations.of(context)!.decline,
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