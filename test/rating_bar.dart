import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double maxRating;
  final Color activeColor;
  final Color inactiveColor;
  final double size;

  const RatingBar({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating.toInt(), (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? activeColor : inactiveColor,
          size: size,
        );
      }),
    );
  }
} 