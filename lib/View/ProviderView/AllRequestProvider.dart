import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/View/ProviderView/RequestDetailsProvider.dart';
import 'package:gp/ViewModel/Requests/AllRequestsVM.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Model/data/model/CustomerRequestsresponse.dart';
import '../../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../../ViewModel/TimeSlot/TimeSlotsVM.dart';

class AllRequestProvider extends StatefulWidget {
  static const String routeName="ProviderRequests";
  String providerID="";
  AllRequestProvider({required this.providerID});

  @override
  State<AllRequestProvider> createState() => _AllRequestProviderState();
}

class _AllRequestProviderState extends State<AllRequestProvider> {
  final AllRequestsVM viewModel = AllRequestsVM(inJectAuthRepoContract());
  final TimeSlotsVM viewModelTime = TimeSlotsVM(inJectAuthRepoContract());
  Widget _buildTile(CustomerRequestsresponse request) {
    return GestureDetector(
      onTap: () async {
        List<AllTimeSlotsResponse> timeslots = await viewModelTime.getAllTimeSlots(request.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestDetailsProvider(widget.providerID,request.id!, request.description,request.location,request.image,request.id!,timeslots),
          ),
        );
      },
      child: Hero(
        tag: 'item${request.id}', // Unique tag for each item
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.request}#${request.id}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.status}: ${request.status}',
                      style: TextStyle(
                        color: MyTheme.primarycol,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.description}:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        request.description ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(Icons.location_on, color: MyTheme.primarycol),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        '${AppLocalizations.of(context)!.location}: ${request.location ?? 'Not Determined'}',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefefef),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.all_request),
      ),
      body: FutureBuilder<List<CustomerRequestsresponse>>(
        future: viewModel.AllRequestsProvider(), // Fetch the list of requests using widget.userId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<CustomerRequestsresponse>? requests = snapshot.data;
            return ListView.builder(
              itemCount: requests!.length,
              itemBuilder: (context, index) {
                return _buildTile(requests[index]);
              },
            );
          }
        },
      ),
    );
  }
}
