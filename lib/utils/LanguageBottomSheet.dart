import 'package:flutter/material.dart';
import 'package:gp/View/MyTheme.dart';
import 'package:provider/provider.dart';

import '../providers/SettingsProvider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                  color: MyTheme.primarycol), // Set the border color to green
              borderRadius:
                  BorderRadius.circular(12.0), // Optional: Set border radius
            ),
            child: InkWell(
              onTap: () {
                settingsProvider.changeLocale('en');
              },
              child: settingsProvider.currentLocale == 'en'
                  ? getSelectedWidget('English')
                  : getUnSelectedWidget('English'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                  color: MyTheme.primarycol), // Set the border color to green
              borderRadius:
                  BorderRadius.circular(12.0), // Optional: Set border radius
            ),
            child: InkWell(
                onTap: () {
                  settingsProvider.changeLocale('ar');
                },
                child: settingsProvider.currentLocale == 'en'
                    ? getUnSelectedWidget('العربية')
                    : getSelectedWidget('العربية')),
          ),

        ],
      ),
    );
  }

  Widget getSelectedWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, color: MyTheme.primarycol),
        ),
        Icon(
          Icons.check,
          color: MyTheme.primarycol,
        )
      ],
    );
  }

  Widget getUnSelectedWidget(String text) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
