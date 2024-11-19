import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedTheme = 'Light';
  String selectedLang = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:REdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Theme',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 8.h,),
          Container(
            height: 48,
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ColorsManger.white,
                border: Border.all(color: ColorsManger.blue, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTheme,
                  style: TextStyle(fontSize: 16, color: ColorsManger.blue),
                ),
                DropdownButton<String>(
                  underline: Container(color: Colors.transparent,),
                  items: <String>['Light', 'Dark'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    selectedTheme = newTheme!;
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 18.h,),
          Text('Language'),
          SizedBox(height: 8.h,),
          Container(
            height: 48,
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ColorsManger.white,
                border: Border.all(color: ColorsManger.blue, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedLang,
                  style: TextStyle(fontSize: 16, color:ColorsManger.blue),
                ),
                DropdownButton<String>(
                  elevation: 0,
                  focusColor: Colors.transparent,
                  underline: Container(color: Colors.transparent),
                  iconDisabledColor: Colors.transparent,
                  isDense: false,
                  isExpanded: false,
                  borderRadius: BorderRadius.zero,
                  focusNode: FocusNode(debugLabel: 'HH'),
                  autofocus: false,
                  items: <String>['English', 'العربيه'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newLang) {
                    selectedLang = newLang!;
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}