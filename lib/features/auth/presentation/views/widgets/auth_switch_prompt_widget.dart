import 'package:flutter/material.dart';

import 'package:education_project_example/core/theme/app_text_styles.dart';

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
          child: Text(actionText, style: AppTextStyles.linkAction),
        ),
      ],
    );
  }
}
