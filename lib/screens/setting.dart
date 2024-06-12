import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/screens/abutScreen.dart';
import 'package:housing/main.dart';
import 'package:housing/models/user_model.dart';
import 'package:housing/screens/LoginScreen.dart';
import 'package:housing/widegts/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text(
            'الإعدادات',
            style: TextStyle(
                fontSize: 20, color: btnColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutScreen()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: backgroundColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'معلومات عن التطبيق',
                          style: TextStyle(
                              fontSize: 18,
                              color: textbtnColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: backgroundColor,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              button(
                text: 'تسجيل الخروج',
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  userModel = UserModel();
                  Get.offAll(const LoginScreen());
                },
                btncolor: Color.fromRGBO(255, 17, 0, 0.85),
              )
            ],
          ),
        ),
      ),
    );
  }
}
