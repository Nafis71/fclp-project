import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_booking_view/air_ticket_apply_view.dart';
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
  late final TextEditingController _nidController;
  late final TextEditingController _passportController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _nidController = TextEditingController();
    _passportController = TextEditingController();
    _formKey = GlobalKey<FormState>();
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
      appBar: customAppBar(context),
      body: Consumer<AirTicketController>(
        builder: (_, airTicketController, __) {
          if (airTicketController.airports.isNotEmpty) {
            if (airTicketController.nid.isNotEmpty) {
              _nidController.text = airTicketController.nid;
            } else {
              _nidController.clear();
            }
            if (airTicketController.passport.isNotEmpty) {
              _passportController.text = airTicketController.passport;
            } else {
              _passportController.clear();
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsPaths.airplaneImage,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AirTicketApplyView(
                    nidController: _nidController,
                    passportController: _passportController,
                    formKey: _formKey,
                    airTicketController: airTicketController,
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.themeColor,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nidController.dispose();
    _passportController.dispose();
    super.dispose();
  }
}
