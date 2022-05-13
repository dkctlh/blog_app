import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/widgets/button_widget.dart';
import 'package:blog_app/widgets/avatar_widget.dart';
import 'package:blog_app/widgets/map_widget.dart';
import 'package:blog_app/widgets/modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Constants/colors_constants.dart';
import '../constants/textstyle_constants.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text("My Profile"),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
              child: SingleChildScrollView(
                child: Column(children: [
                  AvatarView(
                    impicker: () {
                      showBottomSheet(
                          context: context, builder: (context) => ModalView());
                    },
                  ),
                  const SizedBox(
                    height: 32,
                    //geo locator
                  ),
                  state.loc != null
                      ? const MapView()
                      : Container(
                          color: AppColors.buttonBorderColor,
                          height: 174,
                        ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    bgColor: AppColors.buttonWhiteBg,
                    borderColor: AppColors.borderColor,
                    text: "Save",
                    textStyle: TextStylesConsts.passwordText,
                    icon: (Icons.logout_rounded),
                    iconColor: AppColors.borderColor,
                    auth: () {
                      state.updateProfile();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    bgColor: AppColors.borderColor,
                    borderColor: AppColors.borderColor,
                    text: "Log Out",
                    textStyle: TextStylesConsts.loginText,
                    icon: (Icons.logout_rounded),
                    iconColor: AppColors.buttonWhiteBg,
                    auth: () {
                      state.logOut(context);
                    },
                  ),
                ]),
              )));
    });
  }
}
