import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/profil/profil_cubit.dart';

class profil extends StatefulWidget {
  const profil({Key? key}) : super(key: key);

  @override
  _profilState createState() => _profilState();
}

class _profilState extends State<profil> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfilCubit>();
    return BlocBuilder<ProfilCubit, ProfilState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is ProfileError) {
        return Center(child: Text(state.message));
      } else if (state is ProfileImagePicked) ;
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: btnColor,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'البيانات الشخصيه',
              style: TextStyle(fontSize: 20, color: btnColor),
            ),
            backgroundColor: backgroundColor,
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              var userData = snapshot.data!.data()!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: btnColor),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Column(
                                  children: [
                                    //   if(userData['photoUrl']!=null)
                                    Center(
                                        child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage:
                                                userData['photoUrl'] != null
                                                    ? NetworkImage(
                                                        userData['photoUrl'])
                                                    : null)),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Positioned(
                                  top: 70,
                                  right: -20,
                                  bottom: -5,
                                  left: 60,
                                  child: IconButton(
                                    onPressed: () async {
                                      await cubit.imagePaker(context);
                                      await cubit.UploudImageAndUpdata();
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      size: 30,
                                      color: textbtnColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Divider(height: 1),
                        const SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Text(
                              'Email: ${cubit.auth.currentUser!.email}',
                              style: cubit.style,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Get.defaultDialog(
                                      content: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            cubit.updataName = value;
                                          });
                                        },
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () async {
                                            await cubit.updataData(
                                                id: snapshot.data!.id,
                                                key: 'name',
                                                value: cubit.updataName);
                                            setState(() {});
                                          },
                                          child: const Text('updata'),
                                        )
                                      ]);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: textbtnColor,
                                ),
                              ),
                              Text(
                                'Name: ${userData['name']}',
                                style: cubit.style,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Get.defaultDialog(
                                      content: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            cubit.phone = value;
                                          });
                                        },
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () async {
                                            await cubit.updataData(
                                                id: snapshot.data!.id,
                                                key: 'phone',
                                                value: cubit.phone);
                                            setState(() {});
                                          },
                                          child: const Text('updata'),
                                        )
                                      ]);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: textbtnColor,
                                ),
                              ),
                              Text(
                                'Phone Numer: ${userData['phone']}',
                                style: cubit.style,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
