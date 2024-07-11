import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: customAppBar(),
      body: Center(
        child: TicketWidget(
          color: Colors.white60,
          width: 350,
          height: 530,
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
                      border: Border.all(width: 1.0, color: Colors.green),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Business Class',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        'SIA',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.flight_takeoff,
                          color: Colors.pink,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'SMIA',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Flight Ticket',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              ticketDetailsWidget("Passenger", "Nafis Hasan Tonmoy", "Date", "29-07-24"),
              ticketDetailsWidget("Departure", "Dhaka", "Arrival", "Chittagong"),
              ticketDetailsWidget("Class", "Business Class", "Person", "09"),
              ticketDetailsWidget("Price", "Confirmation Pending", "Issued on", "09 July 2024"),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration:
                    const BoxDecoration(image: DecorationImage(image: AssetImage(AssetsPahts.barCode), fit: BoxFit.fill)),
                  ),
                ),
              ),
              Center(
                child: const Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 75.0, right: 75.0),
                  child: Text(
                    'Status : Pending',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget ticketDetailsWidget(String firstTitle, String firstDesc, String secondTitle, String secondDesc) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(firstTitle,style: const TextStyle(color: Colors.grey),),
                ],
              ),
              SizedBox(
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(secondTitle,style: const TextStyle(color: Colors.grey),),
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
                children: [
                  Text(secondDesc)
                ],
              ),
            )

          ],
        ),
      ],
    );
  }
}
