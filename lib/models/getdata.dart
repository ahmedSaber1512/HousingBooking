import 'package:get/get_connect/http/src/request/request.dart';

class GetdataModel {
  String? dataUid, posterUid;
  bool? isAnswerAccept;
  final String address;
  final String description;
  final String selectCity;
  final String selectType;
  final String selectroom;
  final String codeHuosing;
  final String price;
  final List imageUrls;
  final String phone;

  GetdataModel(
      {
       required this.phone, 
        required this.address,
      required this.description,
      required this.selectCity,
      required this.selectType,
      required this.selectroom,
      required this.price,
      required this.codeHuosing,
      required this.imageUrls,
      this.isAnswerAccept,
      this.posterUid,
      this.dataUid});
  factory GetdataModel.fromJson(Map json) {
    return GetdataModel(
     
        isAnswerAccept: json['accept'],
        address: json['address'],
        description: json['description'],
        selectCity: json['selectCity'],
        imageUrls: json['imageUrls'],
        selectType: json['selectType'],
        selectroom: json['selectroom'],
        codeHuosing: json['codeHuosing'],
        price: json['price'],
        posterUid: json['uid'],
         phone: json['phone']
        );
  }

  // Map toJson() => {'address': address};
}
