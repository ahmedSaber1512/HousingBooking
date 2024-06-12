import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/housingScreen/Add_Housing.dart';
import 'package:image_picker/image_picker.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(SAdminCubitInitial());
  TextStyle style = TextStyle(color: textbtnColor, fontSize: 18);

  File? image;

  final FirebaseService service = FirebaseService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  imagePaker(BuildContext context) async {
    final uploudimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (uploudimage != null) {
      // setState(() {
      image = File(uploudimage.path);
      emit(Setsate());
      // });
      UploudImageAndUpdata();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('ضف صورة ')));
    }
  }

  UploudImageAndUpdata() async {
    final storge = FirebaseStorage.instance;
    var file = File(image!.path);
    var snapshot = await storge
        .ref()
        .child('alanat/${_auth.currentUser!.uid}')
        .putFile(file)
        .whenComplete(() {});
    var downloadUrl = await snapshot.ref.getDownloadURL();
    DocumentReference ref = FirebaseFirestore.instance
        .collection('alan')
        .doc(_auth.currentUser!.uid);
    ref.update({'photoUrl': downloadUrl});
  }

  adddedata() async {
    var data = await FirebaseFirestore.instance.collection('datahuosing').get();

    for (var element in data.docs) {
      if (element.data()['status'] == null) {
        await FirebaseFirestore.instance
            .collection('datahuosing')
            .doc(element.id)
            .update({"status": 'pending'});
      }
    }
  }
}
