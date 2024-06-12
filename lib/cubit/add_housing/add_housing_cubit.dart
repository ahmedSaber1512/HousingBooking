import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_housing_state.dart';

class AddHousingCubit extends Cubit<AddHousingState> {
  AddHousingCubit() : super(AddHousingInitial());

  bool isloding = false;
  String? address, description, price, codeHuosing;

  var selectCity;
  var selectType;
  var selectroom;

  File? image1;
  File? image2;
  File? image3;
  File? image4;
  String? userPhone = "";

  final GlobalKey<FormState> formState = GlobalKey();

  TextEditingController controller = TextEditingController();
  TextEditingController addrsscontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController codecontroller = TextEditingController();
  CollectionReference datahuosing =
      FirebaseFirestore.instance.collection('datahuosing');
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

  Future SentImage1() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image1 = File(returnImage!.path);
    emit(UplodeImage());
  }

  Future SentImage2() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image2 = File(returnImage!.path);
    emit(UplodeImage());
  }

  Future SentImage3() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image3 = File(returnImage!.path);
    emit(UplodeImage());
  }

  Future SentImage4() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image4 = File(returnImage!.path);
    emit(UplodeImage());
  }

  Future<String?> uploadImage(File? image, BuildContext context) async {
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرجا استكمال البيانات')));
      return null;
    }

    try {
      // Create a unique filename based on the current timestamp
      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/$fileName');

      final firebase_storage.UploadTask uploadTask = storageRef.putFile(image);
      final firebase_storage.TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      // Handle the error as needed (e.g., show an error message to the user)
      return null;
    }
  }

  Future<Future<DocumentReference<Object?>>> Adddatahuosing(
      BuildContext context) async {
    String? imageUrl1 = await uploadImage(image1, context);
    String? imageUrl2 = await uploadImage(image2, context);
    String? imageUrl3 = await uploadImage(image3, context);
    String? imageUrl4 = await uploadImage(image4, context);

    return datahuosing.add({
      'selectCity': selectCity,
      'selectType': selectType,
      'selectroom': selectroom,
      'address': address,
      'description': description,
      'status': 'pending',
      'price': price,
      'codeHuosing': codeHuosing,
      'imageUrls': [imageUrl1, imageUrl2, imageUrl3, imageUrl4],
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'phone': userPhone
    });
  }
}
