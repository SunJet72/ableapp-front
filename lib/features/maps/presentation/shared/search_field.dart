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
                          FocusScope.of(context).unfocus();
                          final way =
                              context.read<RouteBloc>().state as RouteLoaded;
                          showWayInfo(way.way);
                        } else {}
                      },
                      decoration: InputDecoration(
                        icon: const Icon(Icons.search, color: AppColors.appBlue),
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
                          return const SettingsScreen();
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
    print("sigma");
    var points = way.paths[way.paths.length - 1].points;
    LatLng name = points[points.length - 1];
    double len = name.latitude;
    double lon = name.longitude;
    String adress = "";

    // String ur =
    //     "https://nominatim.openstreetmap.org/reverse?format=json&lat=${len}&lon=${lon}";
    // Uri uri = Uri.parse(ur);
    // try {
    //   final response = await http.get(
    //     uri,
    //     headers: {
    //       'User-Agent': 'Sigma', // Nominatim требует User-Agent
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     final data = json.decode(response.body);
    //     print("data: ${data['display_name']}");
    //     adress = data['display_name'];
    //   } else {
    //     print('Ошибка запроса: ${response.statusCode}');
    //     return null;
    //   }
    // } catch (e) {
    //   print('Ошибка при получении адреса: $e');
    //   return null;
    // }
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Text(adress),
              Row(
                children: [
                  SizedBox(width:MediaQuery.of(context).size.width*0.3 ),
                  const Icon(Icons.timer, color: AppColors.appBlue,),
                  Text( "${(way.duration /1000)}s", style: const TextStyle(color: AppColors.appBlue),),

                  SizedBox(width:MediaQuery.of(context).size.width*0.1 ),
                  const Icon(Icons.location_on, color: AppColors.appBlue), Text(way.distance.toString()),
                ],
              ),

              ProgressBar(way)],

          ),
        );
      },
    );
  }
}
