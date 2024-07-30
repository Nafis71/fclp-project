import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/delivery_confirmation_screen/delivery_confirmation.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Order List"),
      body: Consumer<OrderController>(builder: (_, orderController, __) {
        return ListView.builder(
          itemCount: orderController.orderList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Slidable(
                key: Key(index.toString()),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  openThreshold: 0.1,
                  dismissible: DismissiblePane(
                    onDismissed: (){},
                  ), children: [
                    SlidableAction(onPressed: (context){},
                      borderRadius: BorderRadius.circular(5),
                    icon: Icons.delete,
                      label: "অর্ডার বাতিল করুন",
                      backgroundColor: AppColors.themeColor,
                    )
                ],
                ),
                child: ListTile(
                  tileColor: AppColors.secondaryThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  leading: SvgPicture.asset(
                    AssetsPaths.boxIcon,
                    fit: BoxFit.contain,
                    width: 60,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#Order ${orderController.orderList[index].id}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Total Item: ${orderController.orderList[index].items!.length}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Total Price:",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "\u09F3\t${orderController.orderList[index].total}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Order Date: ${orderController.orderList[index].createdAt}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeliveryConfirmationView(
                                  orderId: orderController.orderList[index].id!,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Pay Fee",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
