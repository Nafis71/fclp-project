import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/screens/delivery_confirmation_screen/delivery_location_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/form_validation_controller.dart';
import '../../widgets/profile_widgets/form_input_decoration.dart';

class DeliveryDetailForm extends StatefulWidget {
  const DeliveryDetailForm({super.key});

  @override
  State<DeliveryDetailForm> createState() => _DeliveryDetailFormState();
}

class _DeliveryDetailFormState extends State<DeliveryDetailForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<OrderController>(builder: (_, orderController, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      splashColor: AppColors.transparent,
                      onTap: () {
                        orderController.setIsInsideDhaka = true;
                        orderController.setIsInsideDhakaPressed = true;
                        orderController.setOutsideDhakaPressed = false;
                      },
                      child: DeliveryLocationContainer(
                          location: "ঢাকার ভিতরে",
                          deliveryAmount: "\u09F380",
                          borderColor: (orderController.isInsideDhakaPressed)
                              ? AppColors.themeColor
                              : Colors.grey,
                          borderWidth: 1,
                          hasPressed: orderController.isInsideDhakaPressed),
                    ),
                    InkWell(
                      splashColor: AppColors.transparent,
                      onTap: () {
                        orderController.setIsInsideDhaka = false;
                        orderController.setIsInsideDhakaPressed = false;
                        orderController.setOutsideDhakaPressed = true;
                      },
                      child: DeliveryLocationContainer(
                          location: "ঢাকার বাহিরে",
                          deliveryAmount: "\u09F3120",
                          borderColor: (orderController.isOutsideDhakaPressed)
                              ? AppColors.themeColor
                              : Colors.grey,
                          borderWidth: 1,
                          hasPressed: orderController.isOutsideDhakaPressed),
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _addressTEController,
                keyboardType: TextInputType.text,
                decoration: formInputDecoration(
                  hintText: "আপনার ঠিকানা",
                ),
                validator: FormValidationController.validateAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<OrderController>(builder: (_, orderController, __) {
                if (orderController.isInsideDhaka) {
                  return const SizedBox.shrink();
                }
                _cityTEController.clear();
                return TextFormField(
                  controller: _cityTEController,
                  keyboardType: TextInputType.text,
                  decoration: formInputDecoration(
                    hintText: "শহরের নাম",
                  ),
                  validator: FormValidationController.validateAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                );
              }),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<OrderController>().recordDeliveryDetails(
                          _addressTEController.text.trim(),
                          _cityTEController.text.trim());
                    }
                  },
                  child: const Text("Next"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}
