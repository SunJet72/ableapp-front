import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';

import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';
import 'package:able_app/features/maps/presentation/blocs/route/route_bloc.dart';
import 'package:able_app/features/maps/presentation/screens/settings_screen.dart';
import 'package:able_app/features/maps/presentation/shared/progress_bar.dart';
import 'package:able_app/features/maps/presentation/shared/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../blocs/location/location_bloc.dart';
import 'package:http/http.dart' as http;

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key});

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  final MapController mapController = MapController();
  final Location location = Location();
  LatLng? currentLocation;
  final formatKey = GlobalKey<FormState>();
  final formatKey1 = GlobalKey<FormState>();


  


  void showInfoHouse1(double len, double lon) async {
    len = 50.935429;
    lon = 11.578313;
    int counter = 20;

    String ur =
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=${len}&lon=${lon}";
    Uri uri = Uri.parse(ur);
    try {
      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'Sigma', // Nominatim требует User-Agent
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("data: ${data['display_name']}");
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      textAlign: TextAlign.center,
                      data['display_name'],
                      style: TextStyle(color: AppColors.appBlue, fontSize: 15),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Text(
                      textAlign: TextAlign.center,
                      "Would you report for a problem?",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 15),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Press \"Report\" to start a contribution!",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 15),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    counter >= 10
                        ? Text(
                          textAlign: TextAlign.center,
                          "This place was reported ${counter} times",
                          style: TextStyle(
                            color: AppColors.appRed,
                            fontSize: 10,
                          ),
                        )
                        : SizedBox(),

                    ElevatedButton(
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
                      child: const Text(
                        "report",
                        style: TextStyle(
                          color: AppColors.appBlue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        return data['display_name'];
      } else {
        print('Ошибка запроса: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Ошибка при получении адреса: $e');
      return null;
    }
  }
  List<Marker> mekers=[];


   void showInfoHouse(double len, double lon) async {
    len = 50.935429;
    lon = 11.578313;
    int counter = 42;

    // String ur =
    //     "https://nominatim.openstreetmap.org/reverse?format=json&lat=${len}&lon=${lon}";
    // Uri uri = Uri.parse(ur);
    
      // final response = await http.get(
      //   uri,
      //   headers: {
      //     'User-Agent': 'Sigma', // Nominatim требует User-Agent
      //   },
      // );

      
        //final data = json.decode(response.body);
        //print("data: ${data['display_name']}");
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    const Text(
                      textAlign: TextAlign.center,
                     // data['display_name'],
                      //data['display_name'],
                      "Landgranf",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 15),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    const Text(
                      textAlign: TextAlign.center,
                      "Would you report for a problem?",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 15),
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "Press \"Report\" to start a contribution!",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 15),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    counter >= 10
                        ? Text(
                          textAlign: TextAlign.center,
                          "This place was reported ${counter} times",
                          style: const TextStyle(
                            color: AppColors.appRed,
                            fontSize: 10,
                          ),
                        )
                        : const SizedBox(),

                    ElevatedButton(
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
                      child: const Text(
                        "report",
                        style: TextStyle(
                          color: AppColors.appBlue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Map')),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                action: SnackBarAction(
                  label: 'Try again',
                  onPressed: () {
                    context.read<LocationBloc>().add(
                      const GetCurrentLocationEvent(),
                    );
                  },
                ),
              ),
            );
          }

        },
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationLoaded) {
            return Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    onLongPress: (mapPosition, letln) {
                      print(mapPosition);
                      print(letln);
                      if(mekers.isNotEmpty){mekers.clear();}
                      mekers.add(Marker(child:Icon(Icons.location_on, color: AppColors.appRed,), point: letln));
                      setState((){});
                      showInfoHouse1(letln.latitude, letln.longitude);
                      
                      //Navigator.of(context).pop();
                    },
                    initialZoom: 17,
                    // initialCenter: state.location,
                    initialCenter: LatLng(50.936535,  11.579461),
                    interactionOptions: const InteractionOptions(
                      flags: ~InteractiveFlag.doubleTapZoom,
                    ),
                  ),
                  children: [
                    
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    
                    BlocBuilder<RouteBloc, RouteState>(
                      builder: (context, state) {
                        print(state);

                        if (state is RouteLoaded) {
                          return PolylineLayer(
                            polylines: [
                              for (final route in state.way.paths)
                                Polyline(
                                  points: route.points,
                                  strokeWidth: 4,
                                  color:  Colors.black,
                                ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    MarkerLayer(
                      markers: [
                       ...mekers
                      ],
                    ),
                    const CurrentLocationLayer(),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    SearchField(formatKey,true),
                    SearchField(formatKey1,false),
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
