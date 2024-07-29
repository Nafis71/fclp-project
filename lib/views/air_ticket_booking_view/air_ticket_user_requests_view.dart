import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/models/air_ticket_model/ticket_data.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_booking_view/air_ticket_view.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ticket_widget/ticket_widget.dart';

class AirTicketUserRequestsView extends StatefulWidget {
  const AirTicketUserRequestsView({
    super.key,
  });

  @override
  State<AirTicketUserRequestsView> createState() =>
      _AirTicketUserRequestsViewState();
}

class _AirTicketUserRequestsViewState extends State<AirTicketUserRequestsView> {
  @override
  void initState() {
    loadTicketData();
    super.initState();
  }

  Future<void> loadTicketData() async {
    await context
        .read<AirTicketController>()
        .loadTicketList(context.read<ProfileController>().token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: customAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await context
              .read<AirTicketController>()
              .loadTicketList(context.read<ProfileController>().token);
        },
        color: AppColors.themeColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<AirTicketController>(
                builder: (_, airTicketController, __) {
              if (airTicketController.ticketData.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TicketWidget(
                          color: Colors.white60,
                          width: 350,
                          height: 550,
                          isCornerRounded: true,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 120.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.green),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          airTicketController
                                              .ticketData[index].types
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        airTicketController
                                            .ticketData[index].departureShort
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.flight_takeoff,
                                          color: Colors.pink,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          airTicketController
                                              .ticketData[index].arrivalShort
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (airTicketController.isDeletingTicket &&
                                  airTicketController.deletingIndex == index)
                                LinearProgressIndicator(
                                    minHeight: 1.5,
                                    color: AppColors.themeColor),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Flight Ticket',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            loadAirTickerInformation(
                                                airTicketController
                                                    .ticketData[index]);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 18,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            deleteTicket(
                                                airTicketController
                                                    .ticketData[index].id!,
                                                index);
                                          },
                                          icon: const Icon(
                                            Icons.delete_outlined,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ticketDetailsWidget(
                                  "Passenger",
                                  context
                                      .read<ProfileController>()
                                      .userData
                                      .name
                                      .toString(),
                                  "Date",
                                  airTicketController
                                      .ticketData[index].travelDate
                                      .toString()),
                              ticketDetailsWidget(
                                  "Departure",
                                  airTicketController
                                      .ticketData[index].from!.divisionName
                                      .toString(),
                                  "Arrival",
                                  airTicketController
                                      .ticketData[index].to!.divisionName
                                      .toString()),
                              ticketDetailsWidget(
                                  "Class",
                                  "${airTicketController.ticketData[index].types}",
                                  "Person",
                                  airTicketController.ticketData[index].person
                                      .toString()),
                              ticketDetailsWidget(
                                  "Price",
                                  airTicketController.ticketData[index].price
                                      .toString(),
                                  "Issued on",
                                  airTicketController
                                      .ticketData[index].createdAt
                                      .toString()),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 30.0, right: 30.0),
                                  child: Container(
                                    width: 90.0,
                                    height: 90.0,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(AssetsPaths.barCode),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 75.0, right: 75.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "Status: ",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 15)),
                                        TextSpan(
                                          text: airTicketController
                                              .ticketData[index].status,
                                          style: TextStyle(
                                              color: AppColors
                                                  .airTicketStatusColor(
                                                      airTicketController
                                                          .ticketData[index]
                                                          .status
                                                          .toString()),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Notice: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: airTicketController
                                          .ticketData[index].notice,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: airTicketController.ticketData.length,
                  ),
                );
              }
              if (!airTicketController.hasTicketFound) {
                return Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AssetsPaths.noTicket,
                        width: 400,
                      ),
                      const Text(AppStrings.noAirTicketMessage),
                    ],
                  ),
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.themeColor,
              ));
            }),
          ],
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    firstTitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      secondTitle,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(firstDesc),
            SizedBox(
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(secondDesc)],
              ),
            )
          ],
        ),
      ],
    );
  }

  void loadAirTickerInformation(TicketData ticketData) {
    AirTicketController airTicketController =
        context.read<AirTicketController>();
    airTicketController.resetData();
    airTicketController.setSilentDepartureAirport = airTicketController.airports
        .where((airport) =>
            airport['airport'] == ticketData.from!.airportName.toString())
        .first;
    airTicketController.setSilentArrivalAirport = airTicketController.airports
        .where((airport) =>
            airport['airport'] == ticketData.to!.airportName.toString())
        .first;
    airTicketController.ticketDate = ticketData.travelDate.toString();
    airTicketController.setCountOfTravellers(
        int.parse(ticketData.person.toString()),
        shouldRefresh: false);
    Map<String, String> ticketTypes = {
      "Economy Class": "ইকোনমি",
      "Business Class": "বিজনেস",
      "Premium Class": "প্রিমিয়াম",
      "First Class": "ফার্স্ট ক্লাস"
    };
    String ticketType = ticketTypes[ticketData.types]!;
    airTicketController.setUiTicketType(ticketType);
    airTicketController.setTicketType = ticketType;
    airTicketController.setNid = ticketData.nid.toString();
    airTicketController.setPassport = ticketData.passport ?? "";
    airTicketController.setTicketId = ticketData.id.toString();
    airTicketController.setStatus = airTicketController
        .getTicketStatusInteger(ticketData.status.toString());
    airTicketController.setTicketNotice = ticketData.notice.toString();
    airTicketController.toggleIsEditMode();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AirTicketView(),
      ),
    ).then((value) {
      airTicketController.toggleIsEditMode();
      airTicketController.resetData(shouldUpdate: true);
      airTicketController.loadTicketList(context.read<ProfileController>().token);
    });
  }

  Future<void> deleteTicket(int ticketId, int index) async {
    bool status = await context.read<AirTicketController>().deleteAirTicket(
        context.read<ProfileController>().token, ticketId, index);
    if (status && mounted) {
      snackBarMessage(
          context: context, message: AppStrings.airTicketDeleteSuccessMessage);
      return;
    }
    if (mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.airTicketDeleteFailureMessage,
          message: AppStrings.airTicketDeleteFailureTitle);
    }
  }
}
