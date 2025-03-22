import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:able_app/features/maps/presentation/screens/main_map_screen.dart';
import 'package:able_app/features/maps/presentation/shared/difficulty_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dial_knob/flutter_dial_knob.dart';

import '../blocs/user/user_bloc.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  StairsEnum stairsCount = StairsEnum.ZERO;
  TerrainEnum sandState = TerrainEnum.HARD;
  TerrainEnum gravelState = TerrainEnum.HARD;
  String selectedStairs = "0";
  String selectedSand = "?";
  String selectedGravel = "?";
  double _stairsCountValue = 0;
  bool wasTouched = false;
  int questionCounter = 0;
  int difficultyIndex = 0;

  void _onStairsCountChanged(double value, BuildContext context) {
    wasTouched = true;
    setState(() {});
    if (value <= 0.2) {
      stairsCount = StairsEnum.ZERO;
      selectedStairs = "0";
    } else if (value > 0.2 && value <= 0.4) {
      stairsCount = StairsEnum.OneTillNine;
      selectedStairs = "1-9";
    } else if (value > 0.4 && value <= 0.6) {
      stairsCount = StairsEnum.TenTillNineteen;
    } else {
      stairsCount = StairsEnum.Unlimited;
      selectedStairs = "Unlimited ∞";
    }
    context.read<UserBloc>().add(ChangeStairsEvent(stairs: stairsCount));
  }

  void _onSendChanged(int value, BuildContext context) {
    wasTouched = true;
    switch (value) {
      case 0:
        sandState = TerrainEnum.EASY;
        selectedSand = "Easy";
        break;
      case 1:
        sandState = TerrainEnum.MEDIUM;
        selectedSand = "Medium";
        break;
      case 2:
        sandState = TerrainEnum.HARD;
        selectedSand = "Hard";
        break;
      case 3:
        sandState = TerrainEnum.IMPOSSIBLE;
        selectedSand = "Impossible";
        break;
    }
    context.read<UserBloc>().add(ChangeSandEvent(sand: sandState));
  }

  void _onGravelChanged(int value, BuildContext context) {
    wasTouched = true;
    switch (value) {
      case 0:
        gravelState = TerrainEnum.EASY;
        selectedGravel = "Easy";
        break;
      case 1:
        gravelState = TerrainEnum.MEDIUM;
        selectedGravel = "Medium";
        break;
      case 2:
        gravelState = TerrainEnum.HARD;
        selectedGravel = "Hard";
        break;
      case 3:
        gravelState = TerrainEnum.IMPOSSIBLE;
        selectedGravel = "Impossible";
        break;
    }
    context.read<UserBloc>().add(ChangeGravelEvent(gravel: gravelState));
  }

  void nextQuestion() {
    setState(() {
      wasTouched = false;
      difficultyIndex = 0;
      questionCounter++;
    });
  }

  Widget buildQuestionContent() {
    List<Widget> question = [];
    switch (questionCounter) {
      case 0:
        question = [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Stairs: ",
                    style: TextStyle(color: AppColors.appBlue, fontSize: 30),
                  ),
                  Text(
                    selectedStairs,
                    style: const TextStyle(
                      color: AppColors.appGrey,
                      fontSize: 30,
                    ),
                  ),
                ],
              );
            },
          ),
          DialKnob(
            knobColor: AppColors.appBlue,
            size: MediaQuery.of(context).size.width * 0.5,
            value: _stairsCountValue,
            onChanged: (value) {
              _onStairsCountChanged(value, context);
            },
          ),
        ];
        break;
      case 1:
        question = [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Cobblestone: ",
                    style: TextStyle(color: AppColors.appBlue, fontSize: 30),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      selectedSand,
                      key: ValueKey<String>(selectedSand),
                      style: const TextStyle(
                        color: AppColors.appGrey,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          DifficultySelector(
            onChanged: (value) {
              difficultyIndex = value;
              _onSendChanged(difficultyIndex, context);
              setState(() {});
            },
            selectedIndex: wasTouched ? difficultyIndex : -1,
          ),
        ];
        break;
      case 2:
        question = [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Gravel: ",
                    style: TextStyle(color: AppColors.appBlue, fontSize: 30),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      selectedGravel,
                      key: ValueKey<String>(selectedGravel),
                      style: const TextStyle(
                        color: AppColors.appGrey,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          DifficultySelector(
            onChanged: (value) {
              difficultyIndex = value;
              _onGravelChanged(difficultyIndex, context);
              setState(() {});
            },
            selectedIndex: wasTouched ? difficultyIndex : -1,
          ),
        ];
        break;
      case 3:
        question = [
          const Text(
            "Thank you!",
            style: TextStyle(color: AppColors.appBlue, fontSize: 50),
          ),
          const Text(
            "Let's find the best",
            style: TextStyle(color: AppColors.appBlue, fontSize: 30),
          ),
          const Text(
            "way!",
            style: TextStyle(color: AppColors.appBlue, fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MainMapScreen();
                  },
                ),
              );
            },
            child: const Text(
              "To the app",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.appBlue),
          ),
        ];
        break;
    }

    return Column(
      key: ValueKey(questionCounter),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...question,
        Opacity(
          opacity: wasTouched ? 1 : 0.4,
          child:
              questionCounter == 3
                  ? const SizedBox()
                  : ElevatedButton(
                    onPressed: () {
                      if (!wasTouched) return;
                      nextQuestion();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBlue,
                    ),
                  ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AbleApp',
          style: TextStyle(
            color: AppColors.appBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: buildQuestionContent(),
        ),
      ),
    );
  }
}
