import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/screens/LoginScreen.dart';
import 'package:housing/widegts/button.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/Splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.height * 1 / 7,
              ),
              const Center(
                child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/logo.png')),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "مرحبًا بك في سكن!\n نحن سعداء بانضمامك إلى مجتمعنا في \nتطبيق 'سكن' نسعى لتوفير تجربة \n سلسة ومريحة .",
                textAlign: TextAlign.center,
                style: textstyle1,
              ),
              const SizedBox(
                height: 100,
              ),
              button(
                  text: 'بدء الإستخدام',
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
