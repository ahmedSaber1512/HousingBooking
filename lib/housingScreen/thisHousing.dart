import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/thisHousing/this_housing_cubit.dart';
import 'package:housing/widegts/button.dart';

// ignore: camel_case_types
class thishousing extends StatefulWidget {
  static const String id = '/thishousing';

  const thishousing({
    Key? key,
  }) : super(key: key);

  @override
  State<thishousing> createState() => _thishousingState();
}

// ignore: camel_case_types

class _thishousingState extends State<thishousing> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThisHousingCubit>();
    return BlocBuilder<ThisHousingCubit, ThisHousingState>(
        builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: btnColor,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'الإطلاع علي تفاصيل السكن',
                style: TextStyle(fontSize: 20, color: btnColor),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo_whit.png'),
                    radius: 18,
                  ),
                ),
              ],
              backgroundColor: backgroundColor,
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('datahuosing')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final snapshotData = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: ListView.builder(
                        itemCount: snapshotData?.docs.length,
                        itemBuilder: (context, index) {
                          var documentsData = snapshotData?.docs[index].data();
                          List? images = documentsData?['imageUrls'];

                          if (documentsData != null &&
                              documentsData.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            for (var i = 0;
                                                i < images!.length;
                                                i++)
                                              Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 0),
                                                  width: context.height / 2,
                                                  height: 150,
                                                  child: ListTile(
                                                    leading: GestureDetector(
                                                      child: const Icon(
                                                        Icons.edit,
                                                        color: textbtnColor,
                                                      ),
                                                      onTap: () async {
                                                        var image = await cubit
                                                            .pickImage();
                                                        if (image != null) {
                                                          await cubit
                                                              .updateImage(
                                                                  image,
                                                                  id: snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                                  imageIndex: i,
                                                                  imagesOld:
                                                                      images);
                                                        }
                                                      },
                                                    ),
                                                    title: Image.network(
                                                      images[i],
                                                      fit: BoxFit.cover,
                                                      //   errorBuilder: (context, error, stackTrace) => Text("check your network"),
                                                      //   loadingBuilder: (context, child, loadingProgress) => Center(
                                                      // child:
                                                      //     CircularProgressIndicator()),
                                                    ),
                                                  )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    190, 224, 232, 234),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                        content: TextField(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              cubit.updatacity =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                        actions: [
                                                          MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              await cubit.updataData(
                                                                  id: snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                                  key:
                                                                      'selectCity',
                                                                  value: cubit
                                                                      .updatacity);
                                                              setState(() {});
                                                            },
                                                            child: const Text(
                                                                'updata'),
                                                          )
                                                        ]);
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: textbtnColor,
                                                  )),
                                              title: Text(
                                                'المحافظه: ${documentsData['selectCity']}   ',
                                                style: textstyle,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    190, 224, 232, 234),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                        content: TextField(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              cubit.updataprice =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                        actions: [
                                                          MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              await cubit.updataData(
                                                                  id: snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                                  value: cubit
                                                                      .updataprice,
                                                                  key: 'price');
                                                              setState(() {});
                                                            },
                                                            child: const Text(
                                                                'updata'),
                                                          )
                                                        ]);
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: textbtnColor,
                                                  )),
                                              title: Text(
                                                  'السعر :  ${documentsData['price']}',
                                                  style: textstyle),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    190, 224, 232, 234),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                        content: TextField(
                                                          onChanged: (value) {
                                                            cubit.updataType =
                                                                value;
                                                          },
                                                        ),
                                                        actions: [
                                                          MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              await cubit.updataData(
                                                                  id: snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                                  value: cubit
                                                                      .updataType,
                                                                  key:
                                                                      'selectType');
                                                              setState(() {});
                                                            },
                                                            child: const Text(
                                                                'updata'),
                                                          )
                                                        ]);
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: textbtnColor,
                                                  )),
                                              title: Text(
                                                'النوع: ${documentsData['selectType']}   ',
                                                style: textstyle,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    190, 224, 232, 234),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                onTap: () {
                                                  Get.defaultDialog(
                                                      content: TextField(
                                                        onChanged: (value) {
                                                          cubit.updataroom =
                                                              value;
                                                        },
                                                      ),
                                                      actions: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            cubit.updataData(
                                                                id: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                                value: cubit
                                                                    .updataroom,
                                                                key:
                                                                    'selectroom');
                                                          },
                                                          child: const Text(
                                                              'updata'),
                                                        )
                                                      ]);
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: textbtnColor,
                                                ),
                                              ),
                                              title: Text(
                                                  ' اخترالسكن  :  ${documentsData['selectroom']}',
                                                  style: textstyle),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    190, 224, 232, 234),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                onTap: () {
                                                  Get.defaultDialog(
                                                      content: TextField(
                                                        onChanged: (value) {
                                                          cubit.updatacodeHuosing =
                                                              value;
                                                        },
                                                      ),
                                                      actions: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            cubit.updataData(
                                                                id: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                                value: cubit
                                                                    .updatacodeHuosing,
                                                                key:
                                                                    'codeHuosing');
                                                          },
                                                          child: const Text(
                                                              'updata'),
                                                        )
                                                      ]);
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: textbtnColor,
                                                ),
                                              ),
                                              title: Text(
                                                'كود السكن : ${documentsData['codeHuosing']}   ',
                                                style: textstyle,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    190, 224, 232, 234),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                onTap: () {
                                                  Get.defaultDialog(
                                                      content: TextField(
                                                        onChanged: (value) {
                                                          cubit.updataAdress =
                                                              value;
                                                        },
                                                      ),
                                                      actions: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            cubit.updataData(
                                                                id: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                                value: cubit
                                                                    .updataAdress,
                                                                key: 'address');
                                                          },
                                                          child: const Text(
                                                              'updata'),
                                                        )
                                                      ]);
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: textbtnColor,
                                                ),
                                              ),
                                              title: Text(
                                                'العنوان: ${documentsData['address']}   ',
                                                style: textstyle,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    190, 224, 232, 234),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ListTile(
                                              leading: GestureDetector(
                                                onTap: () {
                                                  Get.defaultDialog(
                                                      content: TextField(
                                                        onChanged: (value) {
                                                          cubit.updatadescription =
                                                              value;
                                                        },
                                                      ),
                                                      actions: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            cubit.updataData(
                                                                id: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .id,
                                                                value: cubit
                                                                    .updatadescription,
                                                                key:
                                                                    'description');
                                                          },
                                                          child: const Text(
                                                              'updata'),
                                                        )
                                                      ]);
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: textbtnColor,
                                                ),
                                              ),
                                              title: Text(
                                                'الوصف: ${documentsData['description']}   ',
                                                style: textstyle,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      button(
                                          text: 'حذف',
                                          onPressed: () async {
                                            await cubit.deletedData(
                                                snapshot.data!.docs[index].id);
                                            setState(() {});
                                          }),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                    );
                  }),
            )),
      );
    });
  }
}
