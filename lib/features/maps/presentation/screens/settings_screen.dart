import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';
import 'package:able_app/features/maps/presentation/blocs/user/user_bloc.dart';
import 'package:able_app/features/maps/presentation/shared/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  StairsEnum stairsCount = StairsEnum.ZERO;
  TerrainEnum sandState = TerrainEnum.HARD;
  TerrainEnum gravelState = TerrainEnum.HARD;
  String selectedStairs = "0";
  String selectedSand = "?";
  String selectedGravel = "?";
  String selectedLanguage = "English";

  void showWayInfo(Way way) async {
    var points = way.paths[way.paths.length - 1].points;
    LatLng name = points[points.length - 1];
    double len = name.latitude;
    double lon = name.longitude;
    String adress = "";

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
        adress = data['display_name'];
      } else {
        print('Ошибка запроса: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Ошибка при получении адреса: $e');
      return null;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [Text(adress), Text( way.duration.toString()),
            Text(way.distance.toString()),
            ProgressBar(way)],
            
          ),
        );
      },
    );
  }

  int getCount() {
    return 42;
  }

  void showInfoHouse(double len, double lon) async {
    len = 50.935429;
    lon = 11.578313;
    int counter = getCount();

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
                      "Press \"Share\" to start a contribution!",
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

  void _callPhoneNumber(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                color: AppColors.appBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                print("mama");
                _callPhoneNumber("+4917636089141");
              },
              child: const Text("SOS", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appRed,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Stairs: ",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 30),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    DropdownButton<StairsEnum>(
                      value: state.stairs,
                      items: const [
                        DropdownMenuItem<StairsEnum>(
                          child: Text(
                            "0",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: StairsEnum.ZERO,
                        ),
                        DropdownMenuItem<StairsEnum>(
                          child: Text(
                            "1-9",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: StairsEnum.OneTillNine,
                        ),
                        DropdownMenuItem<StairsEnum>(
                          child: Text(
                            "10-19",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: StairsEnum.TenTillNineteen,
                        ),
                        DropdownMenuItem<StairsEnum>(
                          child: Text(
                            "20-50",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: StairsEnum.TwentyTillFifty,
                        ),
                        DropdownMenuItem<StairsEnum>(
                          child: Text(
                            "Unlimited ∞",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: StairsEnum.Unlimited,
                        ),
                      ],
                      onChanged: (index) {
                        switch (index) {
                          case StairsEnum.ZERO:
                            context.read<UserBloc>().add(
                              const ChangeStairsEvent(stairs: StairsEnum.ZERO),
                            );
                            break;
                          case StairsEnum.OneTillNine:
                            context.read<UserBloc>().add(
                              const ChangeStairsEvent(
                                stairs: StairsEnum.OneTillNine,
                              ),
                            );
                            break;
                          case StairsEnum.TenTillNineteen:
                            context.read<UserBloc>().add(
                              const ChangeStairsEvent(
                                stairs: StairsEnum.TenTillNineteen,
                              ),
                            );
                            break;
                          case StairsEnum.TwentyTillFifty:
                            context.read<UserBloc>().add(
                              const ChangeStairsEvent(
                                stairs: StairsEnum.TwentyTillFifty,
                              ),
                            );
                            break;
                          case StairsEnum.Unlimited:
                            context.read<UserBloc>().add(
                              const ChangeStairsEvent(
                                stairs: StairsEnum.Unlimited,
                              ),
                            );
                            break;
                          default:
                            break;
                        }
                      },
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Cobblestone: ",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 30),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    DropdownButton<TerrainEnum>(
                      value: state.sand,
                      items: const [
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Easy",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.EASY,
                        ),
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Medium",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.MEDIUM,
                        ),
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Hard",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.HARD,
                        ),
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Impossible",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.IMPOSSIBLE,
                        ),
                      ],
                      onChanged: (index) {
                        switch (index) {
                          case TerrainEnum.EASY:
                            context.read<UserBloc>().add(
                              const ChangeSandEvent(sand: TerrainEnum.EASY),
                            );
                            break;
                          case TerrainEnum.MEDIUM:
                            context.read<UserBloc>().add(
                              const ChangeSandEvent(sand: TerrainEnum.MEDIUM),
                            );
                            break;
                          case TerrainEnum.HARD:
                            context.read<UserBloc>().add(
                              const ChangeSandEvent(sand: TerrainEnum.HARD),
                            );
                            break;
                          case TerrainEnum.IMPOSSIBLE:
                            context.read<UserBloc>().add(
                              const ChangeSandEvent(
                                sand: TerrainEnum.IMPOSSIBLE,
                              ),
                            );
                            break;
                          default:
                            break;
                        }
                      },
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Gravel: ",
                      style: TextStyle(color: AppColors.appBlue, fontSize: 30),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    DropdownButton<TerrainEnum>(
                      value: state.gravel,
                      items: const [
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Easy",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.EASY,
                        ),
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Medium",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.MEDIUM,
                        ),
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Hard",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.HARD,
                        ),
                        DropdownMenuItem<TerrainEnum>(
                          child: Text(
                            "Impossible",
                            style: TextStyle(
                              color: AppColors.appBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: TerrainEnum.IMPOSSIBLE,
                        ),
                      ],
                      onChanged: (index) {
                        switch (index) {
                          case TerrainEnum.EASY:
                            context.read<UserBloc>().add(
                              const ChangeGravelEvent(gravel: TerrainEnum.EASY),
                            );
                            break;
                          case TerrainEnum.MEDIUM:
                            context.read<UserBloc>().add(
                              const ChangeGravelEvent(
                                gravel: TerrainEnum.MEDIUM,
                              ),
                            );
                            break;
                          case TerrainEnum.HARD:
                            context.read<UserBloc>().add(
                              const ChangeGravelEvent(gravel: TerrainEnum.HARD),
                            );
                            break;
                          case TerrainEnum.IMPOSSIBLE:
                            context.read<UserBloc>().add(
                              const ChangeGravelEvent(
                                gravel: TerrainEnum.IMPOSSIBLE,
                              ),
                            );
                            break;
                          default:
                            break;
                        }
                      },
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       "Language: ",
            //       style: TextStyle(color: AppColors.appBlue, fontSize: 30),
            //     ),
            //     SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            //     DropdownButton<String>(
            //       value: selectedLanguage,
            //       items: const [
            //         DropdownMenuItem<String>(
            //           child: Text(
            //             "English",
            //             style: TextStyle(
            //               color: AppColors.appBlue,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           value: "English",
            //         ),
            //         DropdownMenuItem<String>(
            //           child: Text(
            //             "Deutsch",
            //             style: TextStyle(
            //               color: AppColors.appBlue,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           value: "German",
            //         ),
            //         DropdownMenuItem<String>(
            //           child: Text(
            //             "Espanol",
            //             style: TextStyle(
            //               color: AppColors.appBlue,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           value: "Spanish",
            //         ),
            //       ],
            //       onChanged: (index) {
            //         setState(() {
            //           switch (index) {
            //             case "English":
            //               selectedLanguage = "English";
            //               break;
            //             case "German":
            //               selectedLanguage = "Deutsch";
            //               break;
            //             case "Spanish":
            //               selectedLanguage = "Espanol";
            //               break;
            //             default:
            //               break;
            //           }
            //         });
            //       },
            //     ),
            //   ],
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                //showInfoHouse(0, 0);
                // showWayInfo(null);
              },
              child: const Text("OK", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
