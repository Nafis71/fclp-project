import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/login_widgets/account_login_form_section_widget.dart';
import 'package:fclp_app/widgets/registration_widget/registration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: customAppBar(context),
        drawer: _loginViewDrawer(context),
        body: PopScope(
          canPop: false,
          onPopInvoked: (value) {
            if (context.read<AuthController>().isLoginScreen) {
              SystemNavigator.pop();
            } else {
              context.read<AuthController>().setIsLoginScreen(true);
            }
          },
          child: Center(
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                  duration: const Duration(milliseconds: 1600)),
              child: Consumer<AuthController>(
                builder: (_, viewModel, __) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        (viewModel.isLoginScreen)
                            ? "লগইন ফর্ম"
                            : "নিবন্ধন ফর্ম",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "আমাদের সাথেই থাকুন...",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      if (viewModel.isLoginScreen)
                        const AccountLoginFormSection()
                      else
                        const RegistrationWidget(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginViewDrawer(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "নোটিশ",
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "অ্যাপে লগিন না করলে আপনি অ্যাপ ড্র্যারের এক্সেস পাবেন না।",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("ওকে"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
