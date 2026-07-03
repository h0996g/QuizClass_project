import 'package:flutter/material.dart';

class AuthSwitchPromptWidget extends StatelessWidget {
  const AuthSwitchPromptWidget({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onActionTap,
  });

  final String promptText;

  final String actionText;

  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(promptText),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
