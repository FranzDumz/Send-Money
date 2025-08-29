import 'package:flutter/material.dart';

class ReusableElevatedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const ReusableElevatedButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = theme.elevatedButtonTheme.style;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28, color: theme.primaryColor),
        label: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color:  theme.primaryColor,
          ),
        ),
        style: buttonStyle,
        onPressed: onPressed,
      ),
    );
  }
}
