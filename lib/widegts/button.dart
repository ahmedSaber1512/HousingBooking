import 'package:flutter/material.dart';
import 'package:housing/Colors/colors.dart';

class button extends StatelessWidget {
  button(
      {super.key, required this.text, required this.onPressed, this.btncolor});
  final String text;
  final Color? btncolor;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: backgroundColor,
      ),
      child: MaterialButton(
        color: btncolor ?? backgroundColor,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(color: btnColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: btnColor, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
