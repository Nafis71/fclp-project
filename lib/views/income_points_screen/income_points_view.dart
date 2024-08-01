import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/income_points_screen/point_view.dart';
import 'package:fclp_app/views/income_points_screen/transaction_history.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class IncomePointsView extends StatefulWidget {
  const IncomePointsView({super.key});

  @override
  State<IncomePointsView> createState() => _IncomePointsViewState();
}

class _IncomePointsViewState extends State<IncomePointsView> {
  bool isPaymentIcon = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(
          title: "Income Point",
          preferredSizeWidget: TabBar(
            indicatorColor: AppColors.themeColor,
            dividerHeight: 0.5,
            labelColor: AppColors.themeColor,
            splashBorderRadius: BorderRadius.circular(5),
            overlayColor: WidgetStateProperty.all(AppColors.secondaryThemeColor),
            tabs: const [
              Tab(
                icon: Icon(Icons.account_balance_wallet),
                text: "আপনার মানিব্যাগ",
              ),
              Tab(
                icon: Icon(
                  Icons.account_balance,
                ),
                text: "লেনদেনের ইতিহাস",
              )
            ],
          ),
        ),
        body: const TabBarView(children: [
          PointView(),
          TransactionHistory()
        ],),
      ),
    );
  }
}
