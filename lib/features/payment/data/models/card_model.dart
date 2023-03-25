class CardModel {
  String id ;
  String number ;
  String cvv ;
  String expired ;
  String holder ;

  CardModel ({this.id = "" , this.number , this.cvv , this.expired , this.holder});

  CardModel.fromJson(Map<String, Object> json)
      : this(
    id: json['id'] as String,
    number: json['number'] as String,
    cvv: json['cvv'] as String,
    expired: json['expired'] as String,
    holder: json['holder'] as String,
  );

  Map<String, Object> toJson() {
    return {
      'id': id,
      'number': number,
      'cvv': cvv,
      'expired': expired,
      'holder': holder,
    };
  }

}