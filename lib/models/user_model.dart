class UserModel {
  String? name, number, code, phone, uid;
  late UserRole role;

  UserModel(
      {this.name,
      this.number,
      this.code,
      this.uid,
      this.phone,
      this.role = UserRole.visitor});

  UserModel.fromJson(Map json) {
    name = json['name'];
    number = json['number'];
    code = json['code'];
    phone = json['phone'];
    uid = json['uid'];
    role = toRole(json['role']);
  }

  Map toJson() => {
        'name': name,
        'role': role.name,
        'number': number,
        'code': code,
        'phone': phone,
        'uid': uid
      };

  UserRole toRole(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'poster':
        return UserRole.poster;

      default:
        return UserRole.user;
    }
  }
}

enum UserRole { admin, poster, user , visitor }
