class RegsterModel {
  final String phone;
  final String number;
  final String code;
  final String name;

  RegsterModel(
      {required this.phone,
      required this.number,
      required this.code,
      required this.name});

  factory RegsterModel.FormJson(json) {
    return RegsterModel(
        phone: json['phone'], number: json['number'], code: json['code'], name: json['name']);
  }
}
