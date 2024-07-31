import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/delivery_confirmation_screen/delivery_confirmation.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
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
        return RefreshIndicator(
          backgroundColor: AppColors.themeColor,
          color: Colors.white,
          onRefresh: () async {
            await orderController
                .loadOrderList(context.read<ProfileController>().token);
          },
          child: ListView.builder(
            itemCount: orderController.orderList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Slidable(
                  key: Key(index.toString()),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    openThreshold: 0.1,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          if (orderController.orderList[index].status == "0" ||
                              orderController.orderList[index].status == "4") {
                            orderController.cancelOrder(
                                context.read<ProfileController>().token,
                                orderController.orderList[index].id!);
                          }
                          snackBarMessage(
                              context: context,
                              message: AppStrings.orderCancelErrorMessage);
                        },
                        borderRadius: BorderRadius.circular(5),
                        icon: Icons.delete,
                        label: orderController.orderList[index].status != "4"
                            ? "অর্ডার বাতিল করুন"
                            : "অর্ডার ডিলিট করুন",
                        backgroundColor: AppColors.themeColor,
                      )
                    ],
                  ),
                  child: Material(
                    child: ListTile(
                        tileColor: const Color(0xFFF4F9F9),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
                        trailing: getTrailingWidget(
                            orderController.orderList[index].status.toString(),
                            orderController,
                            index)),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget getTrailingWidget(
      String status, OrderController orderController, int index) {
    if (status == "0") {
      return SizedBox(
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
            ).then((value){
              orderController.resetOrderController();
            });
          },
          child: Text(
            "Pay Fee",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white, fontSize: 10),
          ),
        ),
      );
    } else if (status == "1") {
      return getStatusContainer("প্রক্রিয়াকরণ হচ্ছে", const Color(0xFFFB9B3F));
    } else if (status == "2") {
      return getStatusContainer("বাতিল হয়েছে", Colors.redAccent);
    } else if (status == "3") {
      return getStatusContainer("পাঠানো হয়েছে", Colors.blueAccent);
    } else {
      return getStatusContainer("ডেলিভারি হয়েছে", AppColors.themeColor);
    }
  }

  Widget getStatusContainer(String statusText, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 20,
              offset: const Offset(0, 5),
              blurStyle: BlurStyle.normal)
        ],
      ),
      child: Text(
        statusText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
