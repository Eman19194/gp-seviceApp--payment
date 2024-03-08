import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/View/MakeRequest.dart';
import 'package:gp/View/OffersScreen.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/ViewModel/Requests/AllRequestsVM.dart';
import 'package:gp/Model/data/model/CustomerRequestsresponse.dart';
import 'RequestDetails.dart';

class RequestsTab extends StatefulWidget {
  static String routeName = "RequestsTab";
  final String userId;

  const RequestsTab({Key? key, required this.userId}) : super(key: key);

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  final AllRequestsVM viewModel = AllRequestsVM(inJectAuthRepoContract());

  Widget _buildTile(CustomerRequestsresponse request) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => RequestDetails(
              widget.userId, 
              request.id!,
              request.description,
              request.location,
              request.image,
              request.status,
              request.id!
              ),
          ),
        ).then((value) { setState(() {});});
      },
      child: Card(
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
                    '${AppLocalizations.of(context)!.request} #${request.id}',
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
                  Expanded( // Wrap the Text widget with Expanded
                    child: Text(
                      '${AppLocalizations.of(context)!.location}: ${request.location ?? 'Not Determined'}',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis, // Set overflow behavior
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, OffersScreen.routeName, arguments: request.id);
                    },
                    style: ElevatedButton.styleFrom(primary: MyTheme.primarycol,),
                    child:Text(
                      AppLocalizations.of(context)!.offers,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                )
              ],)
            ],
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
        future: viewModel.getAllRequests(widget.userId),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MakeRequest.routeName, arguments: widget.userId)
              .then((value) { setState(() {});});
        },
        backgroundColor: MyTheme.primarycol,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
