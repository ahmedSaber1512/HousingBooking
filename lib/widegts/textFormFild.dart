import 'package:flutter/material.dart';

import 'package:housing/Colors/colors.dart';

class textformfild extends StatelessWidget {
  textformfild(
      {super.key,
      required this.onChange,
      this.icon,
      required this.hintText,
      this.obscureText = false,
      required this.controller, this.paddingVertical});
  final String hintText;
  Function(String)? onChange;
  bool? obscureText;
  Icon? icon;
  final double? paddingVertical;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: btnColor, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        onChanged: onChange,
        validator: (data) {
          if (data!.isEmpty) {
            return 'ادخل البيانات';
          }
          return null;
        },
        obscureText: obscureText!,
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                 EdgeInsets.symmetric(horizontal: 20, vertical: paddingVertical?? 0),
            suffixIcon: icon,
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      ),
    );
  }
}

class textformfildtwo extends StatelessWidget {
  textformfildtwo(
      {super.key,
      this.icon,
      required this.hintText,
      this.obscureText = false,
      required this.controller});
  final String hintText;
  Function(String)? onChange;
  bool? obscureText;
  Icon? icon;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: btnColor, borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'ادخل البيانات';
          }
          return null;
        },
        obscureText: obscureText!,
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            prefixIcon: icon,
            labelText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
