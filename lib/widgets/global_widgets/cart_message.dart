import 'package:flutter/material.dart';

class SnackBarMessage extends StatelessWidget {
  final String message;

  const SnackBarMessage({
    super.key,
    required this.message,
    required BuildContext context,
  });

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}
