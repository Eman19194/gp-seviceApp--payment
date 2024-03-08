import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gp/Model/data/model/OffersResponse.dart';
import 'package:gp/Repository/repository/auth_repository/repository/authRepoImpl.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:gp/View/ProviderView/OfferDetails.dart';
import 'package:gp/ViewModel/Offers/OffersVM.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryTab extends StatefulWidget {
  static const String routeName = "HistoryTab";
  final String providerId; // Change to providerId
  HistoryTab({required this.providerId});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  final OffersVM viewModel = OffersVM(inJectAuthRepoContract());

  Widget _buildTile(OffersResponse offer) {
    return GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OffersDetails(offer.id!,offer.fees!,offer.timeSlotId!,
              offer.duration,offer.status),
        ),
      );
    },
    child: Hero(
      tag: 'item${offer.id}', // Unique tag for each item
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
          height: 100,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.offer} #${offer.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.status}: ${offer.status}',
                    style: TextStyle(
                      color: MyTheme.primarycol,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
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
        title: Text(AppLocalizations.of(context)!.historyTab),
      ),
      body: FutureBuilder<List<OffersResponse>>(
        future: viewModel.getProviderOffers(widget.providerId), // Fix widget.providerID to widget.providerId
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
            List<OffersResponse>? requests = snapshot.data;
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
