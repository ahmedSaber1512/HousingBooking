import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'booking_housing_state.dart';

class BookingHousingCubit extends Cubit<BookingHousingState> {
  BookingHousingCubit() : super(BookingHousingInitial());
  
  answerOrder(id, bool isAccept, String houseUid) async {
    await FirebaseFirestore.instance.collection('orders').doc(id).update(
        {'order': isAccept ? 'تم الحجز ' : ' محجوز  ', 'answerd': true});
    if (isAccept) {
      FirebaseFirestore.instance
          .collection('datahuosing')
          .doc(houseUid)
          .update({'accept': true});
    }
  }
}
