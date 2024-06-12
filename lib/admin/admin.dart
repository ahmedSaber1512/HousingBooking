import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/admin/admi_cubitn.dart';
import 'package:housing/main.dart';
import 'package:housing/models/getdata.dart';
import 'package:housing/models/user_model.dart';
import 'package:housing/screens/LoginScreen.dart';
import 'package:housing/widegts/btnSmall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin_Screnn extends StatefulWidget {
  static const String id = '/Admin_Screnn';

  const Admin_Screnn({super.key});

  @override
  State<Admin_Screnn> createState() => _Admin_ScrennState();
}

class _Admin_ScrennState extends State<Admin_Screnn> {
  // TextStyle style = TextStyle(color: textbtnColor, fontSize: 18);

  // File? _image;

  // final FirebaseService _service = FirebaseService();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // imagePaker() async {
  //   final uploudimage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (uploudimage != null) {
  //     setState(() {
  //       _image = File(uploudimage.path);
  //     });
  //     UploudImageAndUpdata();
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('ضف صورة ')));
  //   }
  // }

  // UploudImageAndUpdata() async {
  //   final storge = FirebaseStorage.instance;
  //   var file = File(_image!.path);
  //   var snapshot = await storge
  //       .ref()
  //       .child('alanat/${_auth.currentUser!.uid}')
  //       .putFile(file)
  //       .whenComplete(() {});
  //   var downloadUrl = await snapshot.ref.getDownloadURL();
  //   DocumentReference ref = FirebaseFirestore.instance
  //       .collection('alan')
  //       .doc(_auth.currentUser!.uid);
  //   ref.update({'photoUrl': downloadUrl});
  // }

  // adddedata() async {
  //   var data = await FirebaseFirestore.instance.collection('datahuosing').get();

  //   for (var element in data.docs) {
  //     if (element.data()['status'] == null) {
  //       await FirebaseFirestore.instance
  //           .collection('datahuosing')
  //           .doc(element.id)
  //           .update({"status": 'pending'});
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminCubit>();
    return BlocBuilder<AdminCubit,AdminState>(builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: btnColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  userModel = UserModel();
                  Get.offAll(const LoginScreen());
                },
                icon: const Icon(
                  Icons.logout_sharp,
                  color: Colors.red,
                )),
            centerTitle: true,
            title: const Text(
              'قبول او رفض  السكنات',
              style: TextStyle(fontSize: 20, color: btnColor),
            ),
            backgroundColor: backgroundColor,
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('datahuosing')
                .where('status', isEqualTo: 'pending')
                .snapshots(),
            builder: (context, snapshot) {
              cubit.adddedata();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data =
                      GetdataModel.fromJson(snapshot.data!.docs[index].data());
                  data.dataUid = snapshot.data!.docs[index].id;
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: SizedBox(
                                  width: context.width / 1,
                                  height: 200,
                                  child: Image.network(data.imageUrls[0],
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: SizedBox(
                                  width: context.width / 1,
                                  height: 200,
                                  child: Image.network(
                                    data.imageUrls[1],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: SizedBox(
                                  width: context.width / 1,
                                  height: 200,
                                  child: Image.network(data.imageUrls[2],
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: SizedBox(
                                  width: context.width / 1,
                                  height: 200,
                                  child: Image.network(data.imageUrls[3],
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: context.width / 1,
                          height: context.height / 15,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            data.selectCity,
                            style: cubit.style,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: context.width / 1,
                          height: context.height / 15,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            data.address,
                            style: cubit.style,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: context.width / 1,
                          height: context.height / 15,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            data.codeHuosing,
                            style: cubit.style,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: context.width / 1,
                          height: context.height / 15,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            data.selectType,
                            style: cubit.style,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: context.width / 1,
                          height: context.height / 15,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            data.selectroom,
                            style: cubit.style,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          width: context.width / 1,
                          height: context.height / 15,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            data.description,
                            style: cubit.style,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            btnsamll(
                                text: 'قبول',
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('datahuosing')
                                      .doc(data.dataUid)
                                      .update({'status': 'published'});
                                }),
                            btnsamll(
                                text: 'رفض',
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('datahuosing')
                                      .doc(data.dataUid)
                                      .update({'status': 'rejected'});
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: btnColor,
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    });
  }
}
