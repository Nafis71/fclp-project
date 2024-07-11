import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/models/entities/air_ticket_model.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_user_requests_view.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/air_ticket_submit_message.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/airport_selector.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/date_selector.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/ticket_selector.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/travellers_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AirTicketApplyView extends StatefulWidget {
  const AirTicketApplyView({super.key});

  @override
  State<AirTicketApplyView> createState() => _AirTicketApplyViewState();
}

class _AirTicketApplyViewState extends State<AirTicketApplyView> {
  @override
  Widget build(BuildContext context) {
    final airTicketController = Provider.of<AirTicketController>(context);

    final selectedDepartureAirport =
        airTicketController.departureAirport.isEmpty
            ? airTicketController.airports.first
            : airTicketController.departureAirport;

    final selectedArrivalAirport =
        airTicketController.arrivalAirport.isEmpty
            ? airTicketController.airports.last
            : airTicketController.arrivalAirport;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: airportSelector(
                      location: "যাত্রা শুরু",
                      selectedAirport: selectedDepartureAirport,
                      onChanged: (value) {
                        if (mounted) {
                          // setState(() {
                          //   airTicketController.selectedDepartureAirport =
                          //       value;
                          //   if (airTicketController
                          //       .isAirTicketApplyFormFilled) {
                          //   }
                          // });
                        }
                      },
                      airports: airTicketController.airports,
                    ),
                  ),
                  const Icon(
                    Icons.location_searching,
                    size: 30,
                    color: AppColors.grey,
                  ),
                  Expanded(
                    child: airportSelector(
                      location: "যাত্রা শেষ",
                      selectedAirport: selectedArrivalAirport,
                      onChanged: (value) {
                        print("Arrival airport : $value");
                        if (mounted) {
                          // setState(() {
                          //   airTicketController.selectedArrivalAirport =
                          //       value ?? airTicketController.airports.last;
                          //   if (airTicketController
                          //       .isAirTicketApplyFormFilled) {
                          //
                          //   }
                          // });
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
                date: airTicketController.date,
                datePicked: () {
                  airTicketController.datePicked(context);
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TicketSelector(
                      ticket: airTicketController.ticket,
                      typeOfTicket: airTicketController.typeOfTicket,
                      onChanged: (String? newValue) {
                        if (mounted) {
                          setState(() {
                            airTicketController.ticket = newValue ??
                                airTicketController.typeOfTicket.first;
                            if (airTicketController
                                .isAirTicketApplyFormFilled) {

                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TravellerSelector(
                      countOfTravellers: airTicketController.countOfTravellers,
                      travellers: airTicketController.travellers,
                      onChanged: (String? newValue) {
                        if (mounted) {
                          setState(() {
                            airTicketController.countOfTravellers = newValue ??
                                airTicketController.travellers.first;
                            if (airTicketController
                                .isAirTicketApplyFormFilled) {
                            }
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (mounted) {
                    // setState(
                    //   () {
                    //     airTicketController.airTicketFormInfo.add(
                    //       AirTicketModel(
                    //         departureAirport:
                    //             airTicketController.selectedDepartureAirport,
                    //         arrivalAirport:
                    //             airTicketController.selectedArrivalAirport,
                    //         travelDateTime: airTicketController.date,
                    //         ticketType: airTicketController.ticket,
                    //         traveller: airTicketController.countOfTravellers,
                    //       ),
                    //     );
                    //   },
                    // );
                  }
                  airticketSubmissionMessage(context);
                },
                child: const Text("সাবমিট করুন"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.maxFinite),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AirTicketUserRequestsView(
                        defaultArrivalAirport: selectedArrivalAirport,
                        defaultDepartureAirport: selectedDepartureAirport,
                      ),
                    ),
                  );
                },
                child: const Text("আপনার রিকুয়েস্ট সমূহ দেখুন"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
