import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/bkash_withdraw_history_view.dart';
import 'package:fclp_app/views/nagad_withdraw_history_view.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PointWithdrawHistoryView extends StatefulWidget {
  const PointWithdrawHistoryView({super.key});

  @override
  State<PointWithdrawHistoryView> createState() =>
      _PointWithdrawHistoryViewState();
}

class _PointWithdrawHistoryViewState extends State<PointWithdrawHistoryView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(),
        body: const Column(
          children: [
            TabBar(
              dividerColor: Colors.white,
              labelColor: AppColors.themeColor,
              indicatorColor: AppColors.themeColor,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              unselectedLabelColor: AppColors.red,
              tabs: [
                Tab(
                  text: "বিকাশ",
                ),
                Tab(
                  text: "নগদ",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BkashWithdrawHistoryView(),
                  NagadWithdrawHistoryView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
