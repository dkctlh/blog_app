import 'dart:io';

import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/constants/textstyle_constants.dart';
import 'package:blog_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Constants/colors_constants.dart';

class ModalView extends StatefulWidget {
  const ModalView({Key? key}) : super(key: key);

  @override
  State<ModalView> createState() => _ModalViewState();
}

class _ModalViewState extends State<ModalView> {
  final ImagePicker _picker = ImagePicker();

  double height =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return Container(
        height: height * 547 / 844,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                children: [
                  if (state.image?.path != null)
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Image.file(
                        File(state.image!.path),
                        height: 358,
                        width: 358,
                        fit: BoxFit.fill,
                      ),
                    )
                  else
                    Container(
                      height: 358,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: AppColors.buttonBorderColor,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.borderColor,
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      bgColor: AppColors.borderColor,
                      borderColor: AppColors.borderColor,
                      text: "Select",
                      textStyle: TextStylesConsts.loginText,
                      iconColor: AppColors.buttonWhiteBg,
                      icon: (Icons.login_rounded),
                      auth: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: Padding(
                                  padding:
                                      EdgeInsets.only(top: height * 30 / 844),
                                  child: const Center(
                                      child: Text("Select a Picture")),
                                ),
                                content: SizedBox(
                                  height: height * 152 / 844,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: height * 32 / 844,
                                      ),
                                      CustomButton(
                                        bgColor: AppColors.borderColor,
                                        borderColor: AppColors.borderColor,
                                        text: "Camera",
                                        textStyle: TextStylesConsts.loginText,
                                        iconColor: AppColors.buttonWhiteBg,
                                        icon: (Icons.camera_alt_rounded),
                                        auth: () {
                                          state.getImage(
                                              _picker, ImageSource.camera);
                                          setState(() {});
                                        },
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      CustomButton(
                                        bgColor: AppColors.buttonWhiteBg,
                                        borderColor: AppColors.borderColor,
                                        text: "Gallery",
                                        textStyle:
                                            TextStylesConsts.passwordText,
                                        iconColor: AppColors.borderColor,
                                        icon: (Icons
                                            .photo_size_select_large_outlined),
                                        auth: () {
                                          state.getImage(
                                              _picker, ImageSource.gallery);
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  ),
                                )));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomButton(
                      bgColor: AppColors.buttonWhiteBg,
                      borderColor: AppColors.buttonBorderColor,
                      text: "Remove",
                      textStyle: TextStylesConsts.passwordText,
                      iconColor: AppColors.borderColor,
                      icon: (Icons.login_rounded),
                      auth: () {
                        state.removeImage();
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
