import 'package:fclp_app/widgets/global_widgets/withdraw_info_section.dart';
import 'package:flutter/material.dart';

class NagadWithdrawHistoryView extends StatefulWidget {
  const NagadWithdrawHistoryView({super.key});

  @override
  State<NagadWithdrawHistoryView> createState() =>
      _NagadWithdrawHistoryViewState();
}

class _NagadWithdrawHistoryViewState extends State<NagadWithdrawHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const WithdrawInfoSection();
        },
      ),
    );
  }
}
