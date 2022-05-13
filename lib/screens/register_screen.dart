import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/screens/logIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/colors_constants.dart';
import '../constants/textstyle_constants.dart';
import '../services/app_service.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widdget.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = "/register";
  final AppService appService;
  final TextEditingController emailcont = TextEditingController();
  final TextEditingController passcont = TextEditingController();
  final TextEditingController rePasscont = TextEditingController();
  RegisterScreen({Key? key, required this.appService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(child: Text("Sign-up")),
      ),
      body: Consumer<AppState>(builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 124,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 92),
                child: Container(
                  alignment: Alignment.center,
                  height: 174,
                  width: 174,
                  decoration: const BoxDecoration(color: AppColors.containerBg),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              InputWidget(
                hintText: "Email",
                prefixIcon: const Icon(Icons.mail),
                cont: emailcont,
                isObscure: false,
              ),
              const SizedBox(
                height: 16,
              ),
              InputWidget(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: Icons.remove_red_eye,
                cont: passcont,
                isObscure: true,
              ),
              const SizedBox(
                height: 16,
              ),
              InputWidget(
                hintText: "Re-Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: Icons.remove_red_eye,
                cont: rePasscont,
                isObscure: true,
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                textStyle: TextStylesConsts.loginText,
                bgColor: AppColors.borderColor,
                text: "Register",
                borderColor: AppColors.buttonBorderColor,
                icon: Icons.login_rounded,
                iconColor: AppColors.buttonWhiteBg,
                auth: () {
                  if (emailcont.text.isNotEmpty &&
                      passcont.text.isNotEmpty &&
                      rePasscont.text.isNotEmpty) {
                    if (passcont.text == rePasscont.text) {
                      state.signUp(
                          email: emailcont,
                          password: passcont,
                          rePassword: rePasscont,
                          ctx: context);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                textStyle: TextStylesConsts.passwordText,
                bgColor: AppColors.buttonWhiteBg,
                borderColor: AppColors.borderColor,
                text: "Login",
                auth: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                icon: Icons.login_rounded,
                iconColor: AppColors.borderColor,
              )
            ],
          ),
        );
      }),
    );
  }
}
