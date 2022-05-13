import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final String text;
  final auth;
  final TextStyle textStyle;
  final Color iconColor;
  final IconData icon;

  const CustomButton(
      {Key? key,
      required this.bgColor,
      required this.borderColor,
      required this.text,
      required this.textStyle,
      required this.iconColor,
      this.auth,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 56,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(bgColor),
            foregroundColor: MaterialStateProperty.all(borderColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    side: BorderSide(color: borderColor))),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              icon,
              color: iconColor,
            ),
            Text(
              text,
              style: textStyle,
            ),
            const SizedBox(
              width: 30,
              height: 30,
            )
          ]),
          onPressed: auth,
        ));
  }
}
