import 'dart:developer';

import 'package:blog_app/constants/colors_constants.dart';
import 'package:blog_app/context/global_context.dart';
import 'package:flutter/material.dart';

void snackBar(
  String msg,
) {
  var snack = SnackBar(
    content: Text(msg.toString()),
    duration: const Duration(seconds: 3),
    backgroundColor: AppColors.borderColor,
  );
  log("snack");

  ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
      .showSnackBar(snack);
}
