import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';

class btnsamll extends StatelessWidget {
  btnsamll({super.key, required this.text, required this.onPressed});

  final String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: context.width / 3,
        height: 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: btnColor,
        ),
        child: MaterialButton(
          color: backgroundColor,
          shape: const OutlineInputBorder(
              borderSide: BorderSide(color: btnColor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                color: btnColor, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
