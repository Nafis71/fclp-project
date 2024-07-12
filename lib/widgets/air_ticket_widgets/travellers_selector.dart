import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class TravellerSelector extends StatelessWidget {
  final int countOfTravellers;
  final List<int> travellers;
  final ValueChanged<int?>? onChanged;

  const TravellerSelector({
    super.key,
    required this.countOfTravellers,
    required this.travellers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          )]
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            "ভ্রমণকারীর সংখ্যা",
            style: TextStyle(
              color: AppColors.themeColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: countOfTravellers,
              dropdownColor: Colors.white,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.green,
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
              items: travellers.map(
                (int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      "${value.toString()} জন",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                          fontWeight: FontWeight.normal,
                        color: AppColors.black
                      ),
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
