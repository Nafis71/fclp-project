import 'package:fclp_app/widgets/global_widgets/withdraw_info_section.dart';
import 'package:flutter/material.dart';

class BkashWithdrawHistoryView extends StatefulWidget {
  const BkashWithdrawHistoryView({super.key});

  @override
  State<BkashWithdrawHistoryView> createState() =>
      _BkashWithdrawHistoryViewState();
}

class _BkashWithdrawHistoryViewState extends State<BkashWithdrawHistoryView> {
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
