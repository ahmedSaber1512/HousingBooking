import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housing/main.dart';
import 'package:housing/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sinup_state.dart';

class SinupCubit extends Cubit<SinupState> {
  SinupCubit() : super(SinupInitial());
  String? email, password, number, name, phone, code;
  String role = 'poster';
  final auth = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController codecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool lodeing = false;
  final GlobalKey<FormState> formState = GlobalKey();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<UserCredential> SentData() async {
    return await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }

  Future AddUsers() async {
    var userData = await SentData();

    users
        .doc(userData.user?.uid)
        .set({
          'name': name,
          'number': number,
          'phone': phone,
          'code': code,
          "role": role,
          'uid': userData.user?.uid
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    var myData = await FirebaseFirestore.instance
        .collection('users')
        .doc(userData.user?.uid)
        .get();
    userModel = UserModel.fromJson(myData.data()!);
    userModel.uid = myData.id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', json.encode(userModel.toJson()));
    await prefs.setString('userPhone', json.encode(userModel.phone));
  }

}
