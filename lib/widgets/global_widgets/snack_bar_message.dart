import 'package:flutter/material.dart';

void snackBarMessage({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      padding: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
    ),
  );
}
