import 'package:able_app/config/constants/app_colors.dart';
import 'package:able_app/config/enums/terrain_type.dart';
import 'package:able_app/features/maps/domain/entities/way.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
   ProgressBar( Way way){
     this.way = way;
   }
  late Way way;
  final double progress = 0.45; // Прогресс от 0.0 до 1.0

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  final List<String> textures = [
    'lib/images/coublestone_stairs.png',
    'lib/images/grawel.jpg',
    'lib/images/road_stairs.png',
  ];
  final List<double> segmentPercents = [0.3, 0.4, 0.3]; // Сумма = 1.0

void generateProgressBar(){
  segmentPercents.clear();
  textures.clear();
  final pathes = widget.way.paths;

  for(var path in pathes){
    switch(path.terrain){
      case TerrainType.gravel:
        textures.add('lib/images/grawel.jpg');
        segmentPercents.add(path.duration.inMilliseconds.toDouble());
        break;
      case TerrainType.normal:
        textures.add('lib/images/road_stairs.png');
        segmentPercents.add(path.duration.inMilliseconds.toDouble());
        break;
      case TerrainType.sand:
        textures.add('lib/images/coublestone_stairs.png');
        segmentPercents.add(path.duration.inMilliseconds.toDouble());
        break;
    }
    double proportion= path.duration.inMilliseconds.toDouble()/ widget.way.duration.toDouble();
    segmentPercents.add(proportion);
  }
    
}
 @override
Widget build(BuildContext context) {
  final double barWidth = MediaQuery.of(context).size.width * 0.8;
  final double barHeight = 30;
  final double indicatorRadius = 18;
  generateProgressBar();

  return SizedBox(
    width: barWidth + indicatorRadius * 2,
    height: barHeight + indicatorRadius,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Прогрессбар
        Positioned(
          left: indicatorRadius,
          top: (indicatorRadius - barHeight / 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: barWidth,
              height: barHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[900]!, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  _buildFullSegments(barWidth, barHeight),
                  _buildProgressOverlay(barWidth, barHeight),
                ],
              ),
            ),
          ),
        ),

        // Круглый индикатор пользователя
        Positioned(
          left: 0,
          top: 0,
          child: CircleAvatar(
            radius: indicatorRadius,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: indicatorRadius - 2,
              backgroundImage: AssetImage( 'lib/images/cat_logo.png'),
             
            ),
          ),
        ),

        // Финиш-флаг
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            radius: indicatorRadius,
            backgroundColor: AppColors.appBlue,
            child: Icon(Icons.flag, color: Colors.white, size: 18),
          ),
        ),
      ],
    ),
  );
}


  /// Фон: все текстуры по очереди
  Widget _buildFullSegments(double totalWidth, double height) {
    return Row(
  children: List.generate(textures.length, (i) {
    return Expanded(
      flex: (segmentPercents[i] * 1000).round(), // Пропорции в целых числах
      child: Image.asset(
        textures[i],
        fit: BoxFit.cover,
        height: height,
      ),
    );
  }),
);
  }

  /// Прогресс-оверлей: только частично заполняет
  Widget _buildProgressOverlay(double totalWidth, double height) {
    List<Widget> progressSegments = [];
    double usedProgress = 0;

    for (int i = 0; i < textures.length; i++) {
      double maxSegmentProgress = segmentPercents[i];
      double segmentWidth = totalWidth * maxSegmentProgress;

      if (widget.progress <= usedProgress) break;

      double progressInSegment = (widget.progress - usedProgress).clamp(0, maxSegmentProgress);
      double widthFactor = progressInSegment / maxSegmentProgress;

      progressSegments.add(
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: widthFactor,
            child: Image.asset(
              textures[i],
              fit: BoxFit.cover,
              width: segmentWidth,
              height: height,
            ),
          ),
        ),
      );

      usedProgress += maxSegmentProgress;
    }

    return Row(children: progressSegments);
  }
}
