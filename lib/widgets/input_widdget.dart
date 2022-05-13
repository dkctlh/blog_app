import 'package:blog_app/Constants/colors_constants.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String? hintText;
  final Icon? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController cont;
  var isObscure;

  InputWidget({
    Key? key,
    @required this.hintText,
    @required this.prefixIcon,
    this.suffixIcon,
    required this.cont,
    required this.isObscure,
  }) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  var isObscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 358,
      child: TextField(
          controller: widget.cont,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.borderColor)),
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: IconButton(
              icon: Icon(widget.suffixIcon),
              onPressed: () {
                setState(() {
                  widget.isObscure = !widget.isObscure;
                });
              },
            ),
          ),
          obscureText: widget.isObscure),
    );
  }
}
