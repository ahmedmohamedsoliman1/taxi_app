class UserModel {
  String id;

  String phone;

  bool isAdriver ;

  UserModel({this.id, this.phone , this.isAdriver});

  UserModel.fromJson(Map<String, Object> json)
      : this(
    id: json['id'] as String,
    phone: json['phone'] as String,
    isAdriver: json['isAdriver'] as bool,
  );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'phone': phone,
      'isAdriver' : isAdriver
    };
  }
}