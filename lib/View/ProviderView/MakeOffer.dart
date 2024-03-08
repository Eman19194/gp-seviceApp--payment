import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/View/ProviderView/AllRequestProvider.dart';
import 'package:gp/View/UpdateRequest.dart';
import 'package:gp/ViewModel/Offers/ProviderOfferVM.dart';
import 'package:gp/ViewModel/Subcategories/SpecificSubcategoryVM.dart';
import 'package:gp/utils/dialog_utils.dart';
import 'package:gp/utils/text_field_item.dart';
import '../../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../../ViewModel/Offers/ProviderOfferStates.dart';
import '../../utils/DrobDown.dart';
import '../MyTheme.dart';

class ProviderOffer extends StatefulWidget {
  static const String routeName = "ProviderOffer";

  final String? description;
  final String? location;
  final Uint8List? image;
  final int serviceID;
  final List<AllTimeSlotsResponse> timeslots;
  final String providerID;

  ProviderOffer(this.providerID, this.description, this.location, this.image,
      this.serviceID, this.timeslots);

  @override
  _ProviderOfferState createState() => _ProviderOfferState();
}

class _ProviderOfferState extends State<ProviderOffer> {
  int _hours = 0;
  int _minutes = 0;
  TextEditingController feesController = TextEditingController();
  int? _selectedSlotIndex;
  int timeSlotID = 0;
  String duration = '00:00'; // Track the selected slot index
  ProviderOfferVM viewModel = ProviderOfferVM(inJectAuthRepoContract());

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProviderOfferVM, ProviderOfferStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ProviderOfferLoadingState) {
          DialogUtils.showLoading(context, state.loadingMessage!);
        } else if (state is ProviderOfferErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: "Ok", title: "error");
        } else if (state is ProviderOfferSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            state.response.message?.toString() ?? "",
            posActionName: 'Ok',
            title: "Success",
            posAction: () {
              Navigator.pushNamed(context, AllRequestProvider.routeName);
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.request_details),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                    widget.serviceID.toString(),
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
                    widget.description!,
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
                SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.timeSlot, // Add dropdown label
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // Generate containers dynamically for each timeslot
                Column(
                  children: List.generate(widget.timeslots.length, (index) {
                    final slot = widget.timeslots[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyTheme.primarycol),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Radio<int>(
                            value: index,
                            groupValue: _selectedSlotIndex,
                            onChanged: (value) {
                              setState(() {
                                _selectedSlotIndex = value;
                                print("index>>>>>>${_selectedSlotIndex}");
                              });
                            },
                            activeColor: MyTheme.primarycol,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${slot.date} - ${slot.fromTime}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: 8),
                TextFieldItem(
                  fieldName: AppLocalizations.of(context)!.fees,
                  hintText: AppLocalizations.of(context)!.enterFees,
                  controller: feesController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterFees;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.enterDuration,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.primarycol),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${AppLocalizations.of(context)!.selectedDuration}: $duration',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${AppLocalizations.of(context)!.hours}:'),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: MyTheme
                                      .primarycol, // Set active track color to red
                                ),
                                child: Slider(
                                  value: _hours.toDouble(),
                                  min: 0,
                                  max: 24,
                                  onChanged: (value) {
                                    setState(() {
                                      _hours = value.toInt();
                                      _selectDuration(); // Call _selectDuration() when hours change
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${AppLocalizations.of(context)!.minutes}:'),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: MyTheme
                                      .primarycol, // Set active track color to red
                                ),
                                child: Slider(
                                  value: _minutes.toDouble(),
                                  min: 0,
                                  max: 59,
                                  onChanged: (value) {
                                    setState(() {
                                      _minutes = value.toInt();
                                      _selectDuration(); // Call _selectDuration() when minutes change
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () async {
                            int fees = int.tryParse(feesController.text) ?? 0;
                            print("fess>>>${fees}");

                            if (_selectedSlotIndex != null) {
                              final selectedSlot =
                                  widget.timeslots[_selectedSlotIndex!];
                              print(
                                  "Selected Time Slot ID: ${selectedSlot.id}");
                              timeSlotID = selectedSlot.id!;
                              await viewModel.providerOffer(widget.providerID,
                                  widget.serviceID, fees, timeSlotID, duration);
                            } else {
                              // Handle case when no timeslot is selected
                            }
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
                            AppLocalizations.of(context)!.offer,
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
      ),
    );
  }

  void _selectDuration() {
    Duration selectedDuration = Duration(hours: _hours, minutes: _minutes);
    // Format the duration
    String formattedDuration = _formatDuration(selectedDuration);
    // Set the formatted duration to a state variable
    setState(() {
      duration = formattedDuration;
      print("Duration>>>>>>${duration}");
    });
  }

  // Function to format the duration as "h:mm"
  String _formatDuration(Duration duration) {
    String hours = (duration.inHours).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
