import 'package:flutter/material.dart';
import 'package:traveler_guide/core/utils/extensions.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.icon,
    this.alignment = Alignment.center,
    required this.onPressed,
  });

  final IconData icon;

  final Alignment alignment;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 50),
        alignment: alignment,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: context.theme.colorScheme.primary),
      ),
    );
  }
}
