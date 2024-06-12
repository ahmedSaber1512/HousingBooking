// ignore: file_names
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/add_housing/add_housing_cubit.dart';
import 'package:housing/housingScreen/thisHousing.dart';
import 'package:housing/widegts/button.dart';
import 'package:housing/widegts/textFormFild.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Add_Housing extends StatefulWidget {
  static const String id = '/Add_Housing';
  const Add_Housing({
    super.key,
  });

  @override
  State<Add_Housing> createState() => _Add_HousingState();
}

class _Add_HousingState extends State<Add_Housing> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddHousingCubit>();
    return BlocConsumer<AddHousingCubit, AddHousingState>(
        listener: (context, state) {
      if (state is AddHousingSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(state.successMessage),
              backgroundColor: Colors.green),
        );
      } else if (state is AddHousingError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(state.errorMessage), backgroundColor: Colors.red),
        );
      }
    }, builder: (context, state) {
      if (state is AddHousingLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return ModalProgressHUD(
        inAsyncCall: cubit.isloding,
        child: Form(
          key: cubit.formState,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: btnColor,
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'إضافة سكن',
                  style: TextStyle(fontSize: 20, color: btnColor),
                ),
                backgroundColor: backgroundColor,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/logo_whit.png'),
                      radius: 18,
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: DropdownButton(
                                value: cubit.selectCity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                focusColor: btnColor,
                                dropdownColor: btnColor,
                                borderRadius: BorderRadius.circular(10),
                                hint: const Text('اختر المحافظه'),
                                items: [
                                  'القاهرة',
                                  'الجيزة',
                                  'بني سويف',
                                  'الفيوم',
                                ]
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (data) {
                                  setState(() {
                                    cubit.selectCity = data;
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              hint: const Text('اختر الجنس'),
                              items: ['ذكر', 'انثي']
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (data) {
                                setState(() {
                                  cubit.selectType = data;
                                });
                              },
                              value: cubit.selectType,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(5)),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              hint: const Text('اختر نوع الغرفه'),
                              items: [
                                'سنجل',
                                'تربل',
                                'دبل',
                                'شقه',
                              ]
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (data) {
                                setState(() {
                                  cubit.selectroom = data;
                                });
                              },
                              value: cubit.selectroom,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textformfild(
                        controller: cubit.addrsscontroller,
                        onChange: (data) {
                          cubit.address = data;
                        },
                        icon: const Icon(Icons.title),
                        hintText: 'ادخل العنوان'),
                    const SizedBox(
                      height: 20,
                    ),
                    textformfild(
                        paddingVertical: 60,
                        controller: cubit.descontroller,
                        onChange: (data) {
                          cubit.description = data;
                        },
                        icon: const Icon(Icons.description),
                        hintText: 'ادخل الوصف'),
                    const SizedBox(
                      height: 20,
                    ),
                    textformfild(
                        controller: cubit.pricecontroller,
                        onChange: (data) {
                          cubit.price = data;
                        },
                        icon: const Icon(Icons.price_change),
                        hintText: 'ادخل السعر'),
                    const SizedBox(
                      height: 20,
                    ),
                    textformfild(
                        controller: cubit.codecontroller,
                        onChange: (data) {
                          cubit.codeHuosing = data;
                        },
                        icon: const Icon(Icons.code),
                        hintText: 'ادخل كود السكن'),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        cubit.image1 != null
                            ? Expanded(
                                child: Image.file(
                                  File(cubit.image1!.path),
                                  width: context.width / 3,
                                  height: context.height / 3,
                                ),
                              )
                            : Container(
                                width: context.width / 3,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(190, 224, 232, 234),
                                    borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                    onPressed: cubit.SentImage1,
                                    icon: const Icon(Icons.add_a_photo,
                                        size: 30, color: backgroundColor)),
                              ),
                        const SizedBox(
                          width: 30,
                        ),
                        cubit.image2 != null
                            ? Expanded(
                                child: Image.file(
                                  File(cubit.image2!.path),
                                  width: context.width / 3,
                                  height: context.height / 3,
                                ),
                              )
                            : Container(
                                width: context.width / 3,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(190, 224, 232, 234),
                                    borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                    onPressed: cubit.SentImage2,
                                    icon: const Icon(Icons.add_a_photo,
                                        size: 30, color: backgroundColor)),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        cubit.image3 != null
                            ? Expanded(
                                child: Image.file(
                                  File(cubit.image3!.path),
                                  width: context.width / 3,
                                  height: context.height / 3,
                                ),
                              )
                            : Container(
                                width: context.width / 3,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(190, 224, 232, 234),
                                    borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                    onPressed: cubit.SentImage3,
                                    icon: const Icon(Icons.add_a_photo,
                                        size: 30, color: backgroundColor)),
                              ),
                        const SizedBox(
                          width: 30,
                        ),
                        cubit.image4 != null
                            ? Expanded(
                                child: Image.file(
                                  File(cubit.image4!.path),
                                  width: context.width / 3,
                                  height: context.height / 3,
                                ),
                              )
                            : Container(
                                width: context.width / 3,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(190, 224, 232, 234),
                                    borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                    onPressed: cubit.SentImage4,
                                    icon: const Icon(Icons.add_a_photo,
                                        size: 30, color: backgroundColor)),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    button(
                        text: 'ارسال',
                        onPressed: () async {
                          if (cubit.formState.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('تم الارسال بنجاح')));
                          }
                          setState(() {
                            cubit.isloding = true;
                          });
                          try {
                            await cubit.Adddatahuosing(context);
                            Navigator.pushNamed(context, thishousing.id);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$eفشله العمليه')));
                          }
                          cubit.controller.clear();
                          setState(() {
                            cubit.isloding = false;
                          });
                        })
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

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _imageCollection =
      FirebaseFirestore.instance.collection('images');

  Future<String?> uploadImage(File imageFile) async {
    try {
      String userId = _auth.currentUser!.uid;
      String fileName = '${DateTime.now()}_$userId.jpg';

      final firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      await storageRef.putFile(imageFile);

      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> addImagePathToFirestore(String imagePath) async {
    try {
      String userId = _auth.currentUser!.uid;
      await _imageCollection.doc(userId).set({'imagePath': imagePath});
    } catch (e) {
      print('Error adding image path to Firestore: $e');
    }
  }

  Future<String?> pickAndUploadImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String? downloadUrl = await uploadImage(imageFile);
        if (downloadUrl != null) {
          await addImagePathToFirestore(downloadUrl);
          return downloadUrl;
        }
      }

      return null;
    } catch (e) {
      print('Error picking and uploading image: $e');
      return null;
    }
  }
}
