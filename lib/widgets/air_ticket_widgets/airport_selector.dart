import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

Widget airportSelector({
  required String location,
  required Map<String, String> selectedAirport,
  required Function(Map<String, String>) onChanged,
  required List<Map<String, String>> airports,
}) {
  selectedAirport = selectedAirport.isNotEmpty
      ? selectedAirport
      : airports.isNotEmpty
          ? airports.first
          : {};

  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          location,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<Map<String, String>>(
            value: selectedAirport.isNotEmpty ? selectedAirport : null,
            hint: const Text(
              'সিলেক্ট করুন',
              style: TextStyle(
                color: AppColors.green,
              ),
            ),
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: AppColors.green,
            ),
            iconSize: 40,
            icon: const Icon(Icons.arrow_drop_down),
            iconEnabledColor: AppColors.green,
            isDense: true,
            isExpanded: true,
            onChanged: (Map<String, String>? value) {
              if (value != null) {
                onChanged(value);
              }
            },
            items: airports.map(
              (airport) {
                return DropdownMenuItem<Map<String, String>>(
                  value: airport,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        airport['place']!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.green,
                        ),
                      ),
                      Text(
                        airport['airport']!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    ),
  );
}
