import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class TicketSelector extends StatelessWidget {
  final String ticket;
  final List<String> typeOfTicket;
  final ValueChanged<String?>? onChanged;

  const TicketSelector({
    super.key,
    required this.ticket,
    required this.typeOfTicket,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 5,
              offset: const Offset(0, 5),
            )
          ]),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "টিকেটের ধরণ",
            style: TextStyle(
              color: AppColors.themeColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: ticket,
              dropdownColor: Colors.white,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.black,
              ),
              iconSize: 40,
              icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: AppColors.themeColor,
              isDense: true,
              isExpanded: true,
              itemHeight: kMinInteractiveDimension,
              menuMaxHeight: double.maxFinite,
              alignment: AlignmentDirectional.center,
              borderRadius: BorderRadius.circular(20),
              elevation: 16,
              items: typeOfTicket.map(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                  );
                },
              ).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
