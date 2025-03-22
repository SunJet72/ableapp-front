import 'dart:math' as math;
import 'dart:math';

import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/features/maps/presentation/blocs/route/route_bloc.dart';
import 'package:able_app/features/maps/presentation/blocs/user/user_bloc.dart';
import 'package:able_app/features/maps/presentation/shared/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../blocs/location/location_bloc.dart';

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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    final userInfo = state;
                    final location = context.watch<LocationBloc>().state as LocationLoaded;
                    return FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        onTap: (position, point) {
                          context.read<RouteBloc>().add(
                            BuildRouteEvent(
                              stairs: userInfo.stairs,
                              gravel: userInfo.gravel,
                              sand: userInfo.sand,
                              start: location.location,
                              end: point,
                            ),
                          );
                        },
                        initialZoom: 12,
                        initialCenter: location.location,
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
                                      color: Colors.black,
                                    ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        const CurrentLocationLayer(),
                      ],
                    );
                  },
                ),
                Column(
                  children: [
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.05),
                    SearchField(
                      onLocationSelected: (LatLng newLocation) {
                        mapController.move(newLocation, 14);
                      },
                    ),
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
