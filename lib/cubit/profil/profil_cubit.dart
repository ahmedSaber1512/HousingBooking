import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'profil_state.dart';

class ProfilCubit extends Cubit<ProfilState> {
  ProfilCubit() : super(ProfilInitial());
  File? _image;
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextStyle style =  TextStyle(
    fontSize: 15,
  );

  String updataName = '';
  String phone = '';

  
  updataData(
      {required String id, required String key, required String value}) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      key: value,
    });
    Get.back();
  }

  imagePaker(BuildContext context) async {
    final uploudimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (uploudimage != null) {
      
        _image = File(uploudimage.path);
      
      UploudImageAndUpdata();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('ضف صورة ')));
    }
  }

  UploudImageAndUpdata() async {
    final storge = FirebaseStorage.instance;
    var file = File(_image!.path);
    var snapshot = await storge
        .ref()
        .child('userProfil/${auth.currentUser!.uid}')
        .putFile(file)
        .whenComplete(() {});
    var downloadUrl = await snapshot.ref.getDownloadURL();
    DocumentReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid);
    ref.update({'photoUrl': downloadUrl});
  }
}
