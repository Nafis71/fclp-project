import 'package:flutter/material.dart';

class DeliveryDetailsView extends StatefulWidget {
  final int orderId;
  const DeliveryDetailsView({super.key, required this.orderId});

  @override
  State<DeliveryDetailsView> createState() => _DeliveryDetailsViewState();
}

class _DeliveryDetailsViewState extends State<DeliveryDetailsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
