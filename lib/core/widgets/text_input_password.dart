import 'package:flutter/material.dart';

import 'text_input.dart';

class TextInputPassword extends StatefulWidget {
  const TextInputPassword({
    super.key,
    required this.controller,
    this.hint,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.validator,
  });
  final TextEditingController controller;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  @override
  State<TextInputPassword> createState() => _TextInputPasswordState();
}

class _TextInputPasswordState extends State<TextInputPassword> {
  bool _obscured = true;

  void _toggleVisibility() {
    setState(() => _obscured = !_obscured);
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      controller: widget.controller,
      hint: widget.hint,
      prefixIcon: widget.prefixIcon,
      textInputAction: widget.textInputAction,
      obscureText: _obscured,
      validator: widget.validator,
      suffixIcon: IconButton(
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onPressed: _toggleVisibility,
      ),
    );
  }
}
