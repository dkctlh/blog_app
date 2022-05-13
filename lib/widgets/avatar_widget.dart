import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/constants/colors_constants.dart';
import 'package:blog_app/constants/textstyle_constants.dart';
import 'package:blog_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AvatarView extends StatelessWidget {
  final impicker;
  const AvatarView({Key? key, this.impicker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return Stack(
        children: [
          Center(
            child: CircleAvatar(
              radius: 87,
              backgroundColor: AppColors.buttonBorderColor,
              child: Stack(children: [
                if (state.image != null)
                  ClipOval(
                    child: Image.file(
                      File(state.image!.path),
                      height: 174,
                      width: 174,
                      fit: BoxFit.cover,
                    ),
                  ),
                Positioned(
                  left: 103,
                  top: 119,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt_rounded),
                    color: AppColors.borderColor,
                    iconSize: 32,
                    onPressed: impicker,
                  ),
                )
              ]),
            ),
          ),
          Positioned(
            top: 163,
            right: 137,
            child: IconButton(
              icon: Icon(Icons.camera_alt_rounded),
              color: AppColors.buttonWhiteBg,
              iconSize: 28,
              onPressed: () {},
            ),
          )
        ],
      );
    });
  }
}
