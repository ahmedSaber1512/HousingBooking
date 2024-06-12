import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housing/Colors/colors.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: btnColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          title: const Text(
            'تفاصيل الحجز',
            style: TextStyle(fontSize: 25, color: btnColor),
          ),
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('orders')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              var data = snapshot.data?.docs ?? [];
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Card(
                              shadowColor: Color.fromARGB(190, 224, 232, 234),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  child: ListTile(
                                    title: Text(
                                        ' السكن كود : ${data[index]['codeHuosing']} ',
                                        style: const TextStyle(
                                            color: textbtnColor, fontSize: 18)),
                                    leading: Text(data[index]['order'],
                                        style: const TextStyle(
                                            color: backgroundColor,
                                            fontSize: 18)),
                                  )),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
