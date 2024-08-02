import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/profile_widgets/info_section.dart';
import 'package:fclp_app/widgets/profile_widgets/password_section.dart';
import 'package:fclp_app/widgets/profile_widgets/profile_edit_view.dart';
import 'package:fclp_app/widgets/profile_widgets/profile_picture_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: const CustomDrawer(
        fromProfileView: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 24.0,
              left: 24.0,
              top: 24.0,
            ),
            child: Consumer<ProfileController>(
                builder: (_, profileController, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profilePicturePicker(profileController),
                  const SizedBox(
                    height: 16,
                  ),
                  if (profileController.isEdit)
                    InkWell(
                      onTap: () {
                        if (!profileController.isEdit) {
                          return;
                        }
                        profileController.pickImage();
                      },
                      child: Container(
                        height: 48,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "আপনার ছবি পরিবর্তন করুন।",
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  profileController.isEdit == true
                      ? const ProfileEditView()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            infoSection(
                              titleHint: "নাম",
                              title: profileController.userData.name,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            infoSection(
                              titleHint: "ইমেইল",
                              title: profileController.userData.email,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            infoSection(
                              titleHint: "মোবাইল",
                              title: profileController.userData.mobile,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromWidth(110),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                profileController.toggleEdit();
                              },
                              child: const Text("তথ্য সংশোধন করুন"),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "পাসওয়ার্ড পরিবর্তন করুন।",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  passwordSection(
                    formKey: _formKey,
                    newPasswordController: _newPasswordController,
                    confirmPasswordController: _confirmPasswordController,
                    saveNewPassword: () {
                      if (_formKey.currentState!.validate()) {
                        updatePassword();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> updatePassword() async {
    bool status = await context.read<AuthController>().changePassword(
        context.read<ProfileController>().userData.mobile.toString(),
        _newPasswordController.text,
        context.read<ProfileController>());
    if(status && mounted){
      snackBarMessage(context: context, message: AppStrings.passwordChangeSuccessMessage);
      _formKey.currentState!.reset();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      return;
    }
    if(mounted){
      snackBarMessage(context: context, message: AppStrings.passwordChangeFailureMessage);
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
