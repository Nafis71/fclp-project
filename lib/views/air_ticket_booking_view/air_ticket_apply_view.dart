import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_booking_view/air_ticket_form.dart';
import 'package:fclp_app/views/air_ticket_booking_view/air_ticket_user_requests_view.dart';
import 'package:fclp_app/widgets/air_ticket_widgets/air_ticket_submit_message.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/profile_widgets/form_input_decoration.dart';

class AirTicketApplyView extends StatelessWidget {
  final TextEditingController nidController;
  final TextEditingController passportController;
  final GlobalKey<FormState> formKey;
  final AirTicketController airTicketController;

  const AirTicketApplyView({
    super.key,
    required this.nidController,
    required this.passportController,
    required this.formKey,
    required this.airTicketController,
  });

  @override
  Widget build(BuildContext context) {
    if (airTicketController.arrivalAirport.isEmpty) {
      airTicketController.setSilentArrivalAirport =
          airTicketController.airports.last;
      airTicketController.setSilentDepartureAirport =
          airTicketController.airports.first;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          AirTicketForm(
            airTicketController: airTicketController,
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
                      validator: FormValidationController.validateNID),
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
              child: (!airTicketController.isEditMode)
                  ? const Text("সাবমিট করুন")
                  : const Text("তথ্য সংশোধন করুন"),
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
          if (!airTicketController.isEditMode)
            InkWell(
              onTap: () {
                airTicketController.resetData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AirTicketUserRequestsView()));
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
    ProfileController profileController = context.read<ProfileController>();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (airTicketController.ticketDate.isEmpty) {
      warningDialog(
        context: context,
        warningDescription: AppStrings.noDateSelected,
      );
      return;
    }
    if (airTicketController.departureAirport['id'] ==
        airTicketController.arrivalAirport['id']) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.invalidTripMessage,
          message: AppStrings.invalidTripTitle);
      return;
    }
    airTicketController.setNid = nidController.text.trim();
    if (passportController.text.isNotEmpty) {
      airTicketController.setPassport = passportController.text.trim();
    }
    bool status =
        await airTicketController.bookAirTicket(profileController.token);
    if (status && context.mounted) {
      if (airTicketController.isEditMode) {
        snackBarMessage(
            context: context,
            message: AppStrings.airTicketUpdateSuccessMessage);
        Navigator.pop(context);
      } else {
        airticketSubmissionMessage(context);
      }
      nidController.clear();
      passportController.clear();
      airTicketController.resetData(shouldUpdate: true);
      return;
    }
    if (context.mounted) {
      if (airTicketController.isEditMode) {
        warningDialog(
            context: context,
            warningDescription: AppStrings.airTicketUpdateFailureMessage,
            message: AppStrings.airTicketUpdateFailureTitle);
        return;
      }
      warningDialog(
          context: context,
          warningDescription: AppStrings.airTicketBookingFailureMessage,
          message: AppStrings.airTicketBookingFailureTitle);
    }
  }
}
