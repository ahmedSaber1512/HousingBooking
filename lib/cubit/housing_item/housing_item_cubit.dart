import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housing/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

part 'housing_item_state.dart';

class HousingItemCubit extends Cubit<HousingItemState> {
  HousingItemCubit() : super(HousingItemInitial());
  final GlobalKey<FormState> form = GlobalKey();
  TextEditingController phoneNumer = TextEditingController();
  TextEditingController messagewhatsapp = TextEditingController();

  var orderId = 'اريد حجز هذا العقار';
  late UserModel? userModel;
  String? userPhone = "";
  void getPhoneUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userPhone = prefs.getString('userPhone');
    print("***************************");
    print(userPhone);
    print("***************************");
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getPhoneUser();
  // }
sentOrederData(String code, String houseUid, String superUid) {
    FirebaseFirestore.instance.collection('orders').add({
      'order': orderId,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'codeHuosing': code,
      'answerd': false,
      'houseUid': houseUid,
      'SuperUid': superUid
    });
  }

  void sendWhatsAppMessage(String phoneNumber, String message) async {
    // const phoneNumber = '+201026624173';
    // const message = 'hi';
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    await launch(url);
  }
}
