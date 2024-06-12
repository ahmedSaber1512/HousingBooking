import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'this_housing_state.dart';

class ThisHousingCubit extends Cubit<ThisHousingState> {
  ThisHousingCubit() : super(ThisHousingInitial());
  String updatacity = '';
  String updataprice = '';
  String updataType = '';
  String updataroom = '';
  String updatacodeHuosing = '';
  String updataAdress = '';
  String updatadescription = '';
  String updataImage1 = '';
  String updataImage2 = '';
  String updataImage3 = '';
  String updataImage4 = '';
  File? image1;
  Future<XFile?> pickImage() async {
    final uploaging =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return uploaging;
  }

  deletedData(id) async {
    await FirebaseFirestore.instance.collection('datahuosing').doc(id).delete();
  }

  updataData(
      {required String id, required String key, required String value}) async {
    await FirebaseFirestore.instance.collection('datahuosing').doc(id).update({
      key: value,
    });
    Get.back();
  }

  Future updateImage(XFile image,
      {required String id,
      required int imageIndex,
      required List imagesOld}) async {
    String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final Reference storageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');

    final UploadTask uploadTask = storageRef.putFile(File(image.path));
    final TaskSnapshot snapshot = await uploadTask;

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    List images = imagesOld;
    images[imageIndex] = downloadUrl;

    await FirebaseFirestore.instance.collection('datahuosing').doc(id).update({
      'imageUrls': images,
    });
  }

}
