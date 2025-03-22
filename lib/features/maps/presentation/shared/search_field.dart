import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/features/maps/shared/settings_screen.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  SearchField(GlobalKey? key1) {
    this.formatKey = key1 ?? GlobalKey();
  }

  late GlobalKey formatKey;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formatKey,
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: AppColors.appBlue),

                        border: InputBorder.none,
                        labelStyle: TextStyle(color: AppColors.appBlue),
                        labelText: 'Search',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),

              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return SettingsScreen();
                }));
              },
              child: const Icon(Icons.settings, color: AppColors.appBlue),
            ),
          ),
        ],
      ),
    );
  }
}
