import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class TravellerSelector extends StatelessWidget {
  final String countOfTravellers;
  final List<String> travellers;
  final ValueChanged<String?>? onChanged;

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
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "ভ্রমণকারীর সংখ্যা",
            style: TextStyle(
              color: AppColors.green,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: countOfTravellers,
              dropdownColor: Colors.white,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.green,
              ),
              iconSize: 40,
              icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: AppColors.green,
              isDense: true,
              isExpanded: true,
              itemHeight: kMinInteractiveDimension,
              menuMaxHeight: double.maxFinite,
              alignment: AlignmentDirectional.center,
              borderRadius: BorderRadius.circular(20),
              elevation: 16,
              items: travellers.map(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
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
