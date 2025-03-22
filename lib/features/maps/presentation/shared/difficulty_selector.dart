import 'package:flutter/material.dart';

class DifficultySelector extends StatefulWidget {
  final Function(int) onChanged;
  final int selectedIndex;

  const DifficultySelector({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
  });

  @override
  State<DifficultySelector> createState() => _DifficultySelectorState();
}

class _DifficultySelectorState extends State<DifficultySelector> {
  final List<String> labels = ['easy', '', '', 'hard'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double lineWidth = screenWidth * 0.6;
    double circleSize = screenWidth * 0.08;
    double selectedCircleSize = circleSize * 1.5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: selectedCircleSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Горизонтальная линия
              Positioned(
                left: (screenWidth - lineWidth) / 2,
                right: (screenWidth - lineWidth) / 2,
                child: Container(
                  height: 8,
                  color: Colors.blue[900],
                ),
              ),
              // Кружки
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(labels.length, (index) {
                  final isSelected = widget.selectedIndex == index;
                  return GestureDetector(
                    onTap: () => widget.onChanged(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: isSelected ? selectedCircleSize : circleSize,
                      height: isSelected ? selectedCircleSize : circleSize,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.blue[900],
                        border: Border.all(color: Colors.blue[900]!, width: 4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: labels.map((label) {
            return Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
