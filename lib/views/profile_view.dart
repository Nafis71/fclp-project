import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
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
    final profileController = Provider.of<ProfileController>(context);

    return Scaffold(
      appBar: customAppBar(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profilePicturePicker(),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 48,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "আপনার ছবি আপলোড করুন।",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
                            title: profileController.name,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          infoSection(
                            titleHint: "ইমেইল",
                            title: profileController.email,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          infoSection(
                            titleHint: "মোবাইল",
                            title: profileController.mobileNumber,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromWidth(110),
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              profileController.toggleEdit();
                            },
                            child: const Text("Edit"),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "পাসওয়ার্ড পরিবর্তন করুন।",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
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
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
