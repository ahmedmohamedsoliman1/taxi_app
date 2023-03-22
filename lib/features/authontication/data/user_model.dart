class UserModel {
  String id;

  String phone;

  UserModel({this.id, this.phone});

  UserModel.fromJson(Map<String, Object> json)
      : this(
    id: json['id'] as String,
    phone: json['phone'] as String,
  );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'phone': phone,
    };
  }
}