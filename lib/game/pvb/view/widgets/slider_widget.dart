import 'package:flutter/material.dart';
import 'package:x_o_game/shared/apptheme.dart';

class SliderWidget extends StatefulWidget {
  final Function(double) onChanged;
  final int currentIndex;
  final List<String> sliderLabels;
  const SliderWidget({
    super.key,
    required this.onChanged,
    required this.currentIndex,
    required this.sliderLabels,
  });

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    final double min = 0;
    final double max = widget.sliderLabels.length - 1.0;
    final int divisions = widget.sliderLabels.length - 1;
    return SliderTheme(
      data: SliderThemeData(
        activeTickMarkColor: Colors.transparent,
        activeTrackColor: Apptheme.deepDarkNavy,
        inactiveTickMarkColor: Colors.transparent,
        inactiveTrackColor: Apptheme.deepDarkNavy,
        thumbColor: Apptheme.lightBlue,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
        valueIndicatorColor: Colors.transparent,
        trackHeight: 30,
      ),
      child: Slider(
        value: widget.currentIndex.toDouble(),
        min: min,
        max: max,
        divisions: divisions,
        onChanged: widget.onChanged,
      ),
    );
  }
}
