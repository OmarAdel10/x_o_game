import 'package:flutter/cupertino.dart';
import 'package:x_o_game/game/pvb/view/widgets/slider_components_widget.dart';
import 'package:x_o_game/game/pvb/view/widgets/slider_widget.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';

class DifficultySelector extends StatefulWidget {
  const DifficultySelector({super.key});

  @override
  State<DifficultySelector> createState() => _DifficultySelectorState();
}

class _DifficultySelectorState extends State<DifficultySelector> {
  int _currentIndex = 0;

  void handleSliderChanged(double value) {
    setState(() {
      _currentIndex = value.toInt();
      VarManager.botMode = _currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    final sliderLabels = [
      localization.easy,
      localization.medium,
      localization.hard,
    ];

    return Column(
      children: [
        SliderWidget(currentIndex: _currentIndex, sliderLabels: sliderLabels, onChanged: handleSliderChanged,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SliderComponentsWidget(
                currentIndex: _currentIndex,
                sliderLabels: sliderLabels,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
