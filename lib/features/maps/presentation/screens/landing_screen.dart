import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dial_knob/flutter_dial_knob.dart';

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

  void _onStairsCountChanged(double value) {
    if (value <= 0.25) {
      setState(() {
        stairsCount = StairsEnum.ZERO;
      });
    } else if (value > 0.25 && value <= 0.5) {
      setState(() {
        stairsCount = StairsEnum.OneTillNine;
      });
    } else if (value > 0.5 && value <= 0.75) {
      setState(() {
        stairsCount = StairsEnum.TenTillNineteen;
      });
    } else {
      setState(() {
        stairsCount = StairsEnum.Unlimited;
      });
    }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Stairs: ",
                    style: TextStyle(color: AppColors.appBlue, fontSize: 30),
                  ),
                  Text(
                    stairsCount.name,
                    style: const TextStyle(
                      color: AppColors.appGrey,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              DialKnob(
                size: MediaQuery.of(context).size.width * 0.5,
                value: _stairsCountValue,
                onChanged: (value) {
                  _onStairsCountChanged(value);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

