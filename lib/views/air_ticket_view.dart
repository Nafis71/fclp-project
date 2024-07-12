import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_apply_view.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AirTicketView extends StatefulWidget {
  const AirTicketView({super.key});

  @override
  State<AirTicketView> createState() => _AirTicketViewState();
}

class _AirTicketViewState extends State<AirTicketView> {
  @override
  void initState() {
    loadAirportData();
    super.initState();
  }

  Future<void> loadAirportData() async {
    if (context.read<AirTicketController>().airports.isEmpty) {
      await context
          .read<AirTicketController>()
          .loadAirportList(context.read<ProfileController>().token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Consumer<AirTicketController>(
        builder: (_, viewModel, __) {
          if (viewModel.airports.isNotEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsPahts.airplaneImage,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AirTicketApplyView()
                ],
              ),
            );
          }
          return  Center(
            child: CircularProgressIndicator(
              color: AppColors.themeColor,
            ),
          );
        },
      ),
    );
  }
}
