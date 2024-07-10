import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AirTicketUserRequestsView extends StatefulWidget {
  const AirTicketUserRequestsView({
    super.key,
    required this.defaultDepartureAirport,
    required this.defaultArrivalAirport,
  });

  final dynamic defaultDepartureAirport;
  final dynamic defaultArrivalAirport;

  @override
  State<AirTicketUserRequestsView> createState() =>
      _AirTicketUserRequestsViewState();
}

class _AirTicketUserRequestsViewState extends State<AirTicketUserRequestsView> {
  @override
  Widget build(BuildContext context) {
    final airTicketController = Provider.of<AirTicketController>(context);

    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
          itemCount: airTicketController.airTicketFormInfo.length,
          itemBuilder: (context, index) {
            final formInfo = airTicketController.airTicketFormInfo[index];

            return Card(
              color: AppColors.white,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: AppColors.green,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: double.maxFinite,
                        color: AppColors.green,
                        alignment: Alignment.center,
                        child: const FittedBox(
                          child: Text(
                            "টিকিটের বিবরণ",
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "আবেদন নংঃ ${index + 1}",
                        style: const TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "যাত্রা শুরু",
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formInfo.departureAirport['airport'] ??
                            widget.defaultDepartureAirport['airport'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "যাত্রা শেষ",
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formInfo.arrivalAirport['airport'] ??
                            widget.defaultArrivalAirport['airport'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "ভ্রমণের তারিখ",
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formInfo.travelDateTime,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "টিকেটের ধরণ",
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formInfo.ticketType,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "ভ্রমণকারীর সংখ্যা",
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formInfo.traveller,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
