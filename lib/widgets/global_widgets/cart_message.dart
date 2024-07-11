import 'package:flutter/material.dart';

class CartMessage extends StatelessWidget {
  final String message;

  const CartMessage({
    super.key,
    required this.message,
    required BuildContext context,
  });

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}
