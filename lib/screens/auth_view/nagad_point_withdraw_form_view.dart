import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/themes/theme.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NagadPointWithdrawFormView extends StatefulWidget {
  const NagadPointWithdrawFormView({super.key});

  @override
  State<NagadPointWithdrawFormView> createState() =>
      _NagadPointWithdrawFormViewState();
}

class _NagadPointWithdrawFormViewState
    extends State<NagadPointWithdrawFormView> {
  final TextEditingController _numberTEController = TextEditingController();
  final TextEditingController _amountTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(16),
                height: 330,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.themeColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "উত্তলোনের জন্য প্রয়োজনীয় তথ্য দিন।",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.red,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _numberTEController,
                            keyboardType: TextInputType.number,
                            decoration: textFormInputDecoration(
                                hintText: "নগদ নাম্বার লিখুন*"),
                            validator:
                                FormValidationController.validateNagadNumber,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _amountTEController,
                            keyboardType: TextInputType.number,
                            decoration:
                                textFormInputDecoration(hintText: "পরিমান*"),
                            validator:
                                FormValidationController.validateNagadAmount,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  child: ElevatedButton(
                                    style: buttonStyle(
                                        buttonColor: AppColors.blue),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {}
                                    },
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          Text("সাবমিট করুন"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.send)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  child: ElevatedButton(
                                    style:
                                        buttonStyle(buttonColor: AppColors.red),
                                    onPressed: _onTapCloseButton,
                                    child: FittedBox(
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Text("বন্ধ করুন"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(Icons.close)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "নোটিস",
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "* সর্বনিম্ন ব্যালেন্স থাকতে হবে ১০ টাকা।",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "* সর্বনিম্ন উত্তোলনের পরিমান ১০০ টাকা।",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "* উত্তোলন সফল হওয়ার সময় ৩-৫ কার্য দিবস",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "* ২% চার্জ প্রযোজ্য।",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapCloseButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _numberTEController.dispose();
    _amountTEController.dispose();
    super.dispose();
  }
}
