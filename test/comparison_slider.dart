import 'package:flutter/material.dart';

class ComparisonSlider extends StatefulWidget {
  final Widget beforeImage;
  final Widget afterImage;

  const ComparisonSlider({
    super.key,
    required this.beforeImage,
    required this.afterImage,
  });

  @override
  State<ComparisonSlider> createState() => _ComparisonSliderState();
}

class _ComparisonSliderState extends State<ComparisonSlider> {
  double _sliderPosition = 0.5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.beforeImage,
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: _sliderPosition,
            child: widget.afterImage,
          ),
        ),
        Positioned.fill(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: const RectangularSliderTrackShape(),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: _sliderPosition,
              onChanged: (value) => setState(() => _sliderPosition = value),
            ),
          ),
        ),
      ],
    );
  }
} 