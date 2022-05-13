import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/Utils/snackbar_widget.dart';
import 'package:blog_app/constants/colors_constants.dart';
import 'package:blog_app/constants/textstyle_constants.dart';
import 'package:blog_app/services/app_service.dart';
import 'package:blog_app/screens/register_screen.dart';
import 'package:blog_app/widgets/input_widdget.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../widgets/button_widget.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  final TextEditingController emailcont = TextEditingController();
  final TextEditingController passcont = TextEditingController();
  final AppService appService;
  LoginScreen({Key? key, required this.appService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(child: Text("Login")),
      ),
      body: Consumer<AppState>(builder: (context, state, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 175,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 92),
                  child: Container(
                    alignment: Alignment.center,
                    height: 174,
                    width: 174,
                    decoration:
                        const BoxDecoration(color: AppColors.containerBg),
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
                  height: 32,
                ),
                CustomButton(
                  textStyle: TextStylesConsts.loginText,
                  bgColor: AppColors.borderColor,
                  text: "Login",
                  borderColor: AppColors.buttonBorderColor,
                  auth: () {
                    if (emailcont.text.isNotEmpty && passcont.text.isNotEmpty) {
                      state.signIn(
                          email: emailcont, password: passcont, ctx: context);
                    } else {
                      snackBar("Bütün alanları doldurunuz");
                    }
                  },
                  icon: Icons.login_rounded,
                  iconColor: AppColors.buttonWhiteBg,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  textStyle: TextStylesConsts.passwordText,
                  bgColor: AppColors.buttonWhiteBg,
                  borderColor: AppColors.borderColor,
                  text: "Register",
                  auth: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RegisterScreen.routeName);
                  },
                  icon: Icons.login_rounded,
                  iconColor: AppColors.borderColor,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
