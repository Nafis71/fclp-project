import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget dateSelector({
  required BuildContext context,
  required String date,
  required VoidCallback datePicked,
}) {
  return InkWell(
    onTap: datePicked,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          )]
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ভ্রমন এর তারিখ",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: (context.read<AirTicketController>().ticketDate.isNotEmpty) ? AppColors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.calendar_today,
            color: AppColors.themeColor,
          ),
        ],
      ),
    ),
  );
}
