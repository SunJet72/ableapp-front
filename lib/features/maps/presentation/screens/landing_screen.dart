import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
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
  double _stairsCountValue = 0;
  bool wasTouched = false;

  void _onStairsCountChanged(double value, BuildContext context) {
    if (value <= 0.25) {
      stairsCount = StairsEnum.ZERO;
    } else if (value > 0.25 && value <= 0.5) {
      stairsCount = StairsEnum.OneTillNine;
    } else if (value > 0.5 && value <= 0.75) {
      stairsCount = StairsEnum.TenTillNineteen;
    } else {
      stairsCount = StairsEnum.Unlimited;
    }

    context.read<UserBloc>().add(ChangeStairsEvent(stairs: stairsCount));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      state.stairs.name,
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
              size: MediaQuery.of(context).size.width * 0.5,
              value: _stairsCountValue,
              onChanged: (value) {
                _onStairsCountChanged(value, context);
              },
            ),
            Opacity(opacity: wasTouched ? 1 : 0.4,
              child: ElevatedButton(
                    onPressed: () {
                      print("next");
                    },
                    child: Text("OK", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBlue,
                    ),
                  ),
            )
                
                
          ],
        ),
      ),
    );
  }
}
