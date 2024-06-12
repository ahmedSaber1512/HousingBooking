import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housing/main.dart';
import 'package:housing/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  String? email, password;
  bool lodeing = false;
  final auth = FirebaseAuth.instance;

  TextEditingController controller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  final GlobalKey<FormState> formState = GlobalKey();

  getData() async {
    var doAuth = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    if (doAuth.user != null) {
      print('doneeeeeeeee login');
      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(doAuth.user!.uid)
          .get();
      userModel = UserModel.fromJson(data.data()!);
      print('setttttting login');

      userModel.uid = data.id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', json.encode(userModel.toJson()));
      await prefs.setString('userPhone', json.encode(userModel.phone));
    }
  }
}
