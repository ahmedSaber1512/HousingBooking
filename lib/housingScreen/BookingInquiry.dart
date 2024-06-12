import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/bookingHousing/booking_housing_cubit.dart';
import 'package:housing/widegts/btnSmall.dart';

class BookingInquiry extends StatelessWidget {
  const BookingInquiry({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingHousingCubit>();
    return BlocConsumer<BookingHousingCubit, BookingHousingState>(
        listener: (context, state) {
      if (state is OrderSuccess) {
        // Show a success message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      } else if (state is OrderFailure) {
        // Show an error message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error)),
        );
      }
    }, builder: (context, state) {
      if (state is OrderProcessing) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Scaffold(
          backgroundColor: btnColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: backgroundColor,
            title: const Text('استقبال الحجزات',
                style: TextStyle(fontSize: 25, color: btnColor)),
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('SuperUid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where('answerd', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                var data = snapshot.data?.docs ?? [];
                print(
                    "sssssssssssss ${FirebaseAuth.instance.currentUser!.uid}");
                print(data);
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                            color: const Color.fromARGB(190, 224, 232, 234),
                            child: ListTile(
                              leading: Text(
                                  '${data[index]['order']} , ${data[index]['codeHuosing']} ',
                                  style: const TextStyle(
                                      color: textbtnColor, fontSize: 18)),
                              subtitle: btnsamll(
                                onPressed: () {
                                  cubit.answerOrder(snapshot.data!.docs[index].id,
                                      false, data[index]['houseUid']);
                                },
                                text: 'رفض',
                              ),
                              title: btnsamll(
                                onPressed: () {
                                  cubit.answerOrder(snapshot.data!.docs[index].id,
                                      true, data[index]['houseUid']);
                                },
                                text: 'قبول ',
                              ),
                            )),
                      ],
                    );
                  },
                );
              }),
        );
      }
    });
  }
}
