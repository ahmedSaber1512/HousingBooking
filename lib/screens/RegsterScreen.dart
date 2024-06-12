import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/sinup/sinup_cubit.dart';
import 'package:housing/main.dart';
import 'package:housing/widegts/button.dart';
import 'package:housing/widegts/textFormFild.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegsterScreen extends StatefulWidget {
  static const String id = '/RegsterScreen';

  const RegsterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegsterScreen> createState() => _RegsterScreenState();
}

class _RegsterScreenState extends State<RegsterScreen> {
 
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SinupCubit>();
    return BlocConsumer<SinupCubit, SinupState>(
          listener: (context, state) {
            if (state is SinupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User registered successfully!')),
              );
            } else if (state is SinupFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to register user: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is SinupLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return
       ModalProgressHUD(
        inAsyncCall: cubit.lodeing,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: btnColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: Form(
                key: cubit.formState,
                child: ListView(
                  children: [
                    const Center(
                      child: Text(
                        'إنشاء حساب',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/images/logo.png')),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textformfild(
                      controller: cubit.namecontroller,
                      onChange: (value) {
                        cubit.name = value;
                      },
                      icon: const Icon(Icons.person_add),
                      hintText: 'ادخل الاسم',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textformfild(
                      controller: cubit.phonecontroller,
                      onChange: (value) {
                        cubit.phone = value;
                      },
                      icon: const Icon(Icons.phone),
                      hintText: 'ادخل رقم الهاتف',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownMenu(
                        width: 310,
                        hintText: 'اختر   ',
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(
                            label: "صاحب سكن",
                            value: 'poster',
                          ),
                          DropdownMenuEntry(
                            label: "طالب",
                            value: 'user',
                          ),
                        ],
                        onSelected: (v) {
                          cubit.role = v!;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    textformfild(
                      controller: cubit.codecontroller,
                      onChange: (value) {
                        cubit.code = value;
                      },
                      icon: const Icon(Icons.code),
                      hintText: 'ادخل كودك  ',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textformfild(
                      controller: cubit.numbercontroller,
                      onChange: (value) {
                        cubit.number = value;
                      },
                      obscureText: true,
                      icon: const Icon(Icons.numbers),
                      hintText: ' ادخل الرقم القومي',
                    ),
                    const SizedBox(
                      height: 15,
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
                      height: 15,
                    ),
                    textformfild(
                      controller: cubit.passwordcontroller,
                      onChange: (value) {
                        cubit.password = value;
                      },
                      obscureText: true,
                      icon: const Icon(Icons.password),
                      hintText: 'ادخل الرقم السري',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    button(
                        text: 'إنشاء حساب',
                        onPressed: () async {
                          if (cubit.formState.currentState!.validate()) {
                            cubit.lodeing = true;
                            setState(() {});
                            try {
                              await  cubit.AddUsers();
                              Get.offAllNamed(getRoute());
                              if ( cubit.email ==  cubit.email &&  cubit.password ==  cubit.password) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('تم تسجيل الدخول بنجاح')));
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'The password provided is too weak.')));
                              } else if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('هذا الاميل موجود بالفعل')));
                                //The account already exists for that email.
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
      
                             cubit.lodeing = false;
                            setState(() {});
                          } else {}
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'يوجد لديك حساب؟',
                          style: TextStyle(fontSize: 15, color: textbtnColor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text('   قم بتسجيل الدخول',
                              style: TextStyle(fontSize: 15, color: Colors.blue)),
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
