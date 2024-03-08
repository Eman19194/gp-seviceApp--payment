import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gp/Model/data/model/AllTimeSlotsResponse.dart';
import 'package:gp/View/ProviderView/AllRequestProvider.dart';
import 'package:gp/View/UpdateRequest.dart';
import 'package:gp/ViewModel/Offers/ProviderOfferStates.dart';
import 'package:gp/ViewModel/Offers/ProviderOfferVM.dart';
import 'package:gp/utils/dialog_utils.dart';
import 'package:gp/utils/text_field_item.dart';
import '../../Repository/repository/auth_repository/repository/authRepoImpl.dart';
import '../../utils/DrobDown.dart';
import '../MyTheme.dart';

class UpdateOffer extends StatefulWidget {
  static const String routeName="UpdateOffer";

  final String? duration;
  final int offerID;
  // final List<AllTimeSlotsResponse> timeslots;
  final int timeSlotIDD;
  final int fees;

  UpdateOffer(this.duration, this.offerID,this.fees, this.timeSlotIDD,);

  @override
  _UpdateOfferState createState() => _UpdateOfferState();
}

class _UpdateOfferState extends State<UpdateOffer> {
  int _hours = 0;
  int _minutes = 0;
  TextEditingController feesController = TextEditingController();
  int? _selectedSlotIndex;
  int timeSlotID=0;
  String duration='00:00';// Track the selected slot index
  ProviderOfferVM viewModel = ProviderOfferVM (inJectAuthRepoContract());
  @override
  void initState() {
    super.initState();
    // Set the default values received from the constructor
    if (widget.duration != null) {
      List<String> parts = widget.duration!.split(':');
      _hours = int.parse(parts[0]);
      _minutes = int.parse(parts[1]);
      duration = widget.duration!;
    }
    _selectedSlotIndex = widget.timeSlotIDD; // Set the initial selected slot index
  }


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

    child:Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.updateOffer),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                  widget.offerID.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),

              SizedBox(height: 8),
              TextFieldItem(
                fieldName: AppLocalizations.of(context)!.fees,
                hintText: widget.fees.toString(),
                controller: feesController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  // Your validation logic here
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
                                activeTrackColor: MyTheme.primarycol, // Set active track color to red
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
                                activeTrackColor: MyTheme.primarycol, // Set active track color to red
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
                        onPressed: () async{
                          int fees = int.tryParse(feesController.text) ?? 0;
                          print("fess>>>${fees}");

                          if (_selectedSlotIndex != null) {
                            // final selectedSlot = widget.timeslots[_selectedSlotIndex!];
                            // print("Selected Time Slot ID: ${selectedSlot.id}");
                            // timeSlotID=selectedSlot.id!;
                            await viewModel.updateOffer(widget.offerID, fees, widget.timeSlotIDD, duration);
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
                              borderRadius: BorderRadius.circular(
                                  30.0),
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.updateOffer,
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

