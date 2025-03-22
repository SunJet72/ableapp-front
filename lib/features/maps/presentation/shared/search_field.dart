import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/features/maps/presentation/blocs/route/route_bloc.dart';
import 'package:able_app/features/maps/presentation/screens/settings_screen.dart';
import 'package:able_app/features/maps/presentation/shared/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/way.dart';
import '../blocs/user/user_bloc.dart';

class SearchField extends StatefulWidget {
  SearchField(GlobalKey? key1, bool withButton) {
    this.formatKey = key1 ?? GlobalKey();
    this.withButton = withButton;
  }

  bool withButton = false;

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
                      onEditingComplete: () {
                        print(!widget.withButton);
                        final userInfo = context.read<UserBloc>().state;
                        if (!widget.withButton) {
                          context.read<RouteBloc>().add(
                            BuildRouteEvent(
                              stairs: userInfo.stairs,
                              gravel: userInfo.gravel,
                              sand: userInfo.sand,
                              start: const LatLng(50.934282, 11.574699),
                              end: const LatLng(50.936535, 11.579461),
                            ),
                          );
                          final way =
                              context.read<RouteBloc>().state as RouteLoaded;
                          showWayInfo(way.way);
                        } else {}
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: AppColors.appBlue),
                        border: InputBorder.none,
                        labelStyle: const TextStyle(color: AppColors.appBlue),
                        labelText: widget.withButton ? 'From' : 'To',
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

          widget.withButton
              ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),

                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SettingsScreen();
                        },
                      ),
                    );
                  },
                  child: const Icon(Icons.settings, color: AppColors.appBlue),
                ),
              )
              : SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        ],
      ),
    );
  }

  void showWayInfo(Way way) async {
    var points = way.paths[way.paths.length - 1].points;
    LatLng name = points[points.length - 1];
    double len = name.latitude;
    double lon = name.longitude;
    String adress = "";

    // String ur =
    //     "https://nominatim.openstreetmap.org/reverse?format=json&lat=${len}&lon=${lon}";
    // Uri uri = Uri.parse(ur);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Text(adress),
              Text(way.duration.toString()),
              Text(way.distance.toString()),
              ProgressBar(way),
            ],
          ),
        );
      },
    );
  }
}
