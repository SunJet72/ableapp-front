import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/features/maps/presentation/blocs/user/user_bloc.dart';
import 'package:able_app/features/maps/presentation/shared/progress_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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


  void _callPhoneNumber(String number) async {
  final Uri url = Uri(scheme: 'tel', path: number);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
   print("Could not laungh $url");
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
                    child: const Text(
                      "SOS",
                      style: TextStyle(color: Colors.white),
                    ),
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
                      "Sand: ",
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
              },
              child: const Text("OK", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appBlue,
              ),
            ),
            ProgressBar()
          ],
        ),
      ),
    );
  }
}
