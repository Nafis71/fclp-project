import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/services/prefetch_service.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:fclp_app/views/home_screen/home_product_widget/product_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_view_wigets/air_ticket_banner.dart';
import 'home_view_wigets/help_service_buttons.dart';
import 'home_view_wigets/product_service_buttons.dart';
import 'home_view_wigets/welcome_banner.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    loadInitialData();
    super.initState();
  }

  Future<void> loadInitialData() async {
    try {
      await Future.wait([
        PrefetchService.loadCartData(context),
        PrefetchService.loadProductData(1, context),
        PrefetchService.loadOrderList(context),
      ]);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context),
        drawer: const CustomDrawer(
          fromHomeView: true,
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              const WelcomeBanner(),
              const HelpServiceButtons(),
              const AirTicketBanner(),
              const ProductServiceButtons(),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ]),
                  child: const Center(
                    child: FittedBox(
                      child: Text(
                        "আপনার প্রয়োজনীয় পণ্য",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const ProductGridView(),
            ],
          ),
        ),
      ),
    );
  }



  void _scrollListener() {
    if (!context.read<ProductController>().isLoading &&
        context.read<ProductController>().nextPageAvailable) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page += 1;
        PrefetchService.loadProductData(page,context, fromScrollListener: true);
      }
    }
  }
}
