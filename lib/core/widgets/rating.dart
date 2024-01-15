import 'package:flutter/material.dart';
import 'package:traveler_guide/core/utils/extensions.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < rating; i++)
          const Icon(Icons.star, color: Colors.amber, size: 16),
        for (var i = 0; i < 5 - rating; i++)
          const Icon(Icons.star_border, color: Colors.amber,  size: 16),
        const SizedBox(width: 4),
        Text('$rating', style: context.textTheme.labelSmall),
      ],
    );
  }
}
