import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/models/air_ticket_model/ticket_data.dart';
import 'package:flutter/material.dart';

import '../../utils/color_palette.dart';
import '../../widgets/air_ticket_widgets/airport_selector.dart';
import '../../widgets/air_ticket_widgets/date_selector.dart';
import '../../widgets/air_ticket_widgets/ticket_selector.dart';
import '../../widgets/air_ticket_widgets/travellers_selector.dart';

class AirTicketForm extends StatelessWidget {
  final AirTicketController airTicketController;

  const AirTicketForm({super.key, required this.airTicketController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: airportSelector(
                location: "যাত্রা শুরু",
                selectedAirport: airTicketController.departureAirport,
                onChanged: (departureAirport) {
                  airTicketController.setDepartureAirport = departureAirport;
                },
                airports: airTicketController.airports,
              ),
            ),
            Icon(
              Icons.airplane_ticket_rounded,
              size: 35,
              color: AppColors.themeColor,
            ),
            Expanded(
              child: airportSelector(
                location: "যাত্রা শেষ",
                selectedAirport: airTicketController.arrivalAirport,
                onChanged: (arrivalAirport) {
                  if (context.mounted) {
                    airTicketController.setArrivalAirport = arrivalAirport;
                  }
                },
                airports: airTicketController.airports,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        dateSelector(
          context: context,
          date: (airTicketController.ticketDate.isEmpty)
              ? "তারিখ নির্বাচন করুন"
              : airTicketController.ticketDate.toString(),
          datePicked: () {
            airTicketController.datePicked(context);
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TicketSelector(
                ticket: airTicketController.uITicketType,
                typeOfTicket: airTicketController.typeOfTicket,
                onChanged: (String? ticketType) {
                  if (context.mounted && ticketType != null) {
                    airTicketController.setTicketType = ticketType;
                    airTicketController.setUiTicketType(ticketType);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TravellerSelector(
                countOfTravellers: airTicketController.countOfTravellers,
                travellers: airTicketController.travellers,
                onChanged: (int? newValue) {
                  if (context.mounted) {
                    airTicketController.setCountOfTravellers(
                        newValue ?? airTicketController.travellers.first);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getTicketDate(
      TicketData? ticketData, AirTicketController airTicketController) {
    if (ticketData != null) {
      return ticketData.travelDate.toString();
    }
    return (airTicketController.ticketDate.isEmpty)
        ? "তারিখ নির্বাচন করুন"
        : airTicketController.ticketDate.toString();
  }
}
