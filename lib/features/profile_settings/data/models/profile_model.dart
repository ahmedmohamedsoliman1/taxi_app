class ProfileModel {
  String id;

  String name;

  String homeAddress;

  String businessAddress;

  String shoppingCenter;

  String image ;

  ProfileModel(
      {this.id = "", this.name, this.businessAddress, this.homeAddress, this.shoppingCenter , this.image});

  ProfileModel.fromJson(Map<String, Object> json)
      : this(
    id: json['id'] as String,
    name: json['name'] as String,
    homeAddress: json['home_address'] as String,
    businessAddress: json['business_address'] as String,
    shoppingCenter: json['shopping_address'] as String,
    image: json['image'] as String,
  );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'home_address': homeAddress,
      'business_address': businessAddress,
      'shopping_address': shoppingCenter,
      'image': image,
    };
  }
}
