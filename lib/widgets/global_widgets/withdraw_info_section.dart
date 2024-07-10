import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WithdrawInfoSection extends StatefulWidget {
  const WithdrawInfoSection({super.key});

  @override
  State<WithdrawInfoSection> createState() => _WithdrawInfoSectionState();
}

class _WithdrawInfoSectionState extends State<WithdrawInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "উইথড্র",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            Text(
              "- ট 100",
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "0177777777777",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMd()
                      .add_jms()
                      .format(
                        DateTime.now(),
                      )
                      .toString(),
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transaction ID: BF9827CD",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  color: AppColors.grey,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
