
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/login/login_cubit.dart';
import 'package:housing/main.dart';
import 'package:housing/screens/RegsterScreen.dart';
import 'package:housing/widegts/button.dart';
import 'package:housing/widegts/textFormFild.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginSuccess) {
      } else if (state is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error)),
        );
      }
    }, builder: (context, state) {
      if (state is LoginLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return ModalProgressHUD(
        inAsyncCall:cubit.lodeing,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Form(
                key: cubit.formState,
                child: ListView(
                  children: [
                    SizedBox(height: context.height / 15),
                    const Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: context.height / 14),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/images/logo.png')),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    textformfild(
                      controller: cubit.emailcontroller,
                      onChange: (value) {
                        cubit.email = value;
                      },
                      icon: const Icon(Icons.email),
                      hintText: 'ادخل البريد الاكتروني',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textformfild(
                      controller: cubit.passwordcontroller,
                      onChange: (value) {
                        cubit.password = value;
                      },
                      obscureText: true,
                      icon: const Icon(Icons.visibility_off),
                      hintText: 'ادخل الرقم السري',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    button(
                        text: 'تسجيل الدخول',
                        onPressed: () async {
                          if (cubit.formState.currentState!.validate()) {
                           cubit.lodeing = true;
                            setState(() {});

                            try {
                              await cubit.getData();

                              Get.toNamed(getRoute());

                              if (cubit.email == cubit.email && cubit.password == cubit.password) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('تم تسجيل الدخول بنجاح')));
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code != cubit.password) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'اعادة كتابة الرقم السري او الاميل بشكل صحيح')));
                              } else if (e.code != cubit.email) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'No user found for that email.')));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                            //  ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text('تم تسجيل الدخول بنجاح')));
                            cubit.lodeing = false;
                            setState(() {});
                          } else {}
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(fontSize: 15, color: textbtnColor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RegsterScreen.id);
                          },
                          child: const Text('   إنشاء حساب',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
