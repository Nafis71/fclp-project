import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomePointHistoryView extends StatefulWidget {
  const IncomePointHistoryView({super.key});

  @override
  State<IncomePointHistoryView> createState() => _IncomePointHistoryViewState();
}

class _IncomePointHistoryViewState extends State<IncomePointHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                    color: AppColors.themeColor,
                  ),
                ),
              ),
              title: Row(
                children: [
                  Text(
                    "Earning",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(
                    Icons.star,
                    color: AppColors.amber,
                    size: 20,
                  )
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Points: 100"),
                  Text(
                    DateFormat.yMd()
                        .add_jms()
                        .format(DateTime.now())
                        .toString(),
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
