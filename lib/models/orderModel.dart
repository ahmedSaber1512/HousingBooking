import 'package:firebase_auth/firebase_auth.dart';

class Order {
  // final String address;
  // final String roomType;
  final String codeHuosing;
  final String uid;

  Order({
    required this.uid,
    // required this.address,
    // required this.roomType,
    required this.codeHuosing,
  });
}

Order tojson() {
  return Order(
      // address: 'address',
      // roomType: 'selectroom',
      codeHuosing: 'codeHuosing',
      uid: FirebaseAuth.instance.currentUser!.uid);
}
