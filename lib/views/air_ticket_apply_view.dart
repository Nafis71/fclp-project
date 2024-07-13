import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_user_requests_view.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/air_ticket_submit_message.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/airport_selector.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/date_selector.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/ticket_selector.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/travellers_selector.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_widgets/form_input_decoration.dart';

class AirTicketApplyView extends StatelessWidget {
  final TextEditingController nidController;
  final TextEditingController passportController;
  final GlobalKey<FormState> formKey;
  const AirTicketApplyView(
      {super.key,
      required this.nidController,
      required this.passportController, required this.formKey});

  @override
  Widget build(BuildContext context) {
    if (context.read<AirTicketController>().arrivalAirport.isEmpty) {
      context.read<AirTicketController>().setSilentArrivalAirport =
          context.read<AirTicketController>().airports.last;
      context.read<AirTicketController>().setSilentDepartureAirport =
          context.read<AirTicketController>().airports.first;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: airportSelector(
                  location: "যাত্রা শুরু",
                  selectedAirport:
                      context.read<AirTicketController>().departureAirport,
                  onChanged: (departureAirport) {
                    context.read<AirTicketController>().setDepartureAirport =
                        departureAirport;
                  },
                  airports: context.read<AirTicketController>().airports,
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
                  selectedAirport:
                      context.read<AirTicketController>().arrivalAirport,
                  onChanged: (arrivalAirport) {
                    if (context.mounted) {
                      context.read<AirTicketController>().setArrivalAirport =
                          arrivalAirport;
                    }
                  },
                  airports: context.read<AirTicketController>().airports,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          dateSelector(
            context: context,
            date: (context.read<AirTicketController>().ticketDate.isEmpty)
                ? "তারিখ নির্বাচন করুন"
                : context.read<AirTicketController>().ticketDate,
            datePicked: () {
              context.read<AirTicketController>().datePicked(context);
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TicketSelector(
                  ticket: context.read<AirTicketController>().uITicketType,
                  typeOfTicket:
                      context.read<AirTicketController>().typeOfTicket,
                  onChanged: (String? ticketType) {
                    if (context.mounted && ticketType != null) {
                      context.read<AirTicketController>().setTicketType =
                          ticketType;
                      context.read<AirTicketController>().setUiTicketType =
                          ticketType;
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TravellerSelector(
                  countOfTravellers:
                      context.read<AirTicketController>().countOfTravellers,
                  travellers: context.read<AirTicketController>().travellers,
                  onChanged: (int? newValue) {
                    if (context.mounted) {
                      context.read<AirTicketController>().setCountOfTravellers =
                          newValue ??
                              context
                                  .read<AirTicketController>()
                                  .travellers
                                  .first;
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
            key: formKey,
              child: Column(
            children: [
              TextFormField(
                controller: nidController,
                keyboardType: TextInputType.number,
                decoration: formInputDecoration(
                  hintText: "আপনার NID নম্বর",
                ),
                validator: FormValidationController.validateNID
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passportController,
                keyboardType: TextInputType.number,
                decoration: formInputDecoration(
                  hintText: "আপনার পাসপোর্ট নম্বর (Optional)",
                ),
              ),
            ],
          )),
          const SizedBox(height: 20),
          if (!context.read<AirTicketController>().isLoading)
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 4),
              onPressed: () {
                bookAirTicket(context);
              },
              child: const Text("সাবমিট করুন"),
            )
          else
            Center(
              child: CircularProgressIndicator(
                color: AppColors.themeColor,
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AirTicketUserRequestsView()));
            },
            child: Text(
              "আপনার রিকুয়েস্ট সমূহ দেখুন",
              style: TextStyle(
                  color: AppColors.themeColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> bookAirTicket(BuildContext context) async {
    if(!formKey.currentState!.validate()){
      return;
    }
    if (context.read<AirTicketController>().ticketDate.isEmpty) {
      warningDialog(
        context: context,
        warningDescription: AppStrings.noDateSelected,
      );
      return;
    }
    if (context.read<AirTicketController>().departureAirport['id'] ==
        context.read<AirTicketController>().arrivalAirport['id']) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.invalidTripMessage,
          message: AppStrings.invalidTripTitle);
      return;
    }
    context.read<AirTicketController>().setNid = nidController.text.trim();
    if(passportController.text.isNotEmpty){
      context.read<AirTicketController>().setPassport = passportController.text.trim();
    }
    bool status = await context
        .read<AirTicketController>()
        .bookAirTicket(context.read<ProfileController>().token);
    if (status && context.mounted) {
      airticketSubmissionMessage(context);
      return;
    }
    if (context.mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.airTicketBookingFailureMessage,
          message: AppStrings.airTicketBookingFailureTitle);
    }
  }
}
