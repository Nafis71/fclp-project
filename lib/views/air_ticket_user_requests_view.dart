import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
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
        onRefresh: ()async{
          await context.read<AirTicketController>().loadTicketList(context.read<ProfileController>().token);
        },
        color: AppColors.themeColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<AirTicketController>(builder: (_, viewModel, __) {
              if (viewModel.ticketData.isNotEmpty) {
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          viewModel.ticketData[index].types
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
                                        viewModel.ticketData[index].departureShort.toString(),
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
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          viewModel.ticketData[index].arrivalShort.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Flight Ticket',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(onPressed: (){}, icon: const Icon(Icons.edit,size: 18,),),
                                        IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outlined,size: 18,),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ticketDetailsWidget(
                                  "Passenger",
                                  context.read<ProfileController>().name,
                                  "Date",
                                  viewModel.ticketData[index].travelDate
                                      .toString()),
                              ticketDetailsWidget(
                                  "Departure",
                                  viewModel.ticketData[index].from!.divisionName
                                      .toString(),
                                  "Arrival",
                                  viewModel.ticketData[index].to!.divisionName
                                      .toString()),
                              ticketDetailsWidget(
                                  "Class",
                                  "${viewModel.ticketData[index].types} Class",
                                  "Person",
                                  viewModel.ticketData[index].person.toString()),
                              ticketDetailsWidget(
                                  "Price",
                                  viewModel.ticketData[index].price.toString(),
                                  "Issued on",
                                  viewModel.ticketData[index].createdAt
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
                                                AssetImage(AssetsPahts.barCode),
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
                                          text:
                                              viewModel.ticketData[index].status,
                                          style: TextStyle(
                                              color:
                                                  AppColors.airTicketStatusColor(
                                                      viewModel.ticketData[index]
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
                                      text: viewModel.ticketData[index].notice,
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
                    itemCount: viewModel.ticketData.length,
                  ),
                );
              }
              if(!viewModel.hasTicketFound){
                return Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(AssetsPahts.noTicket, width: 400,),
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
}
