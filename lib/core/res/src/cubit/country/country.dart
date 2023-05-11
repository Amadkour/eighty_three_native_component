// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final int id;
  final String? name;
  final String code;
  final String uuid;
  final String currencyCode;
  final String ?icon;

  const Country({
    required this.id,
    required this.name,
    required this.uuid,
    required this.code,
    required this.currencyCode,
    this.icon
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
      uuid: map['uuid'] as String,
      currencyCode: map['currency_code'] as String,
      icon : map["icon"]!=null?map['icon'] as String:"https://cdn.eightyythree.com/public/uploads/currencies/sa.svg"
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => <Object>[id, name!, code, currencyCode,uuid];
}
