import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/widgets/profile_widgets/form_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final TextEditingController _newNameController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newMobileNumberController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    _newNameController.text = profileController.name;
    _newEmailController.text = profileController.email;
    _newMobileNumberController.text = profileController.mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            controller: _newNameController,
            decoration: formInputDecoration(),
            validator: FormValidationController.validateName,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _newEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: formInputDecoration(),
            validator: FormValidationController.validateEmail,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _newMobileNumberController,
            keyboardType: TextInputType.number,
            decoration: formInputDecoration(),
            validator: FormValidationController.validateMobileNumber,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(110),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              FormValidationController.handleSave(
                context,
                _formKey,
                _newNameController,
                _newEmailController,
                _newMobileNumberController,
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _newNameController.dispose();
    _newEmailController.dispose();
    _newMobileNumberController.dispose();
    super.dispose();
  }
}
