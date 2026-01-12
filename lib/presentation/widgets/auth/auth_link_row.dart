import 'package:flutter/material.dart';

/// Auth link row for navigation between login/signup
class AuthLinkRow extends StatelessWidget {
  final String message;
  final String linkText;
  final VoidCallback onPressed;

  const AuthLinkRow({
    super.key,
    required this.message,
    required this.linkText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: TextStyle(color: Colors.grey[600])),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: Text(linkText),
        ),
      ],
    );
  }
}
