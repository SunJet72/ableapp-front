import 'package:able_app/config/enums/stairs_enum.dart';
import 'package:able_app/config/enums/terrain_enum.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  StairsEnum stairsCount = StairsEnum.ZERO;
  TerrainEnum sandState = TerrainEnum.HARD;
  TerrainEnum gravelState = TerrainEnum.HARD;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}