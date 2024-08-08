import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DeliveryConfirmationFinish extends StatelessWidget {
  const DeliveryConfirmationFinish({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderController>().resetOrderController();
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SvgPicture.asset(
                AssetsPaths.deliveryPaymentDone,
                width: 320,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.secondaryThemeColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "আপনার অর্ডার নিশ্চিত করা হয়েছে এবং আপনার ডেলিভারি পেমেন্ট এর তথ্য শীঘ্রই যাচাই করা হবে!  FCLP এর সাথে কেনাকাটার জন্য ধন্যবাদ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 5),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ফিরে যান"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
