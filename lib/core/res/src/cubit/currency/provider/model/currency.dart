// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final int id;
  final String uuid;
  final String iso2Code;
  final String iso3Code;
  final bool isActive;
  final String country;
  final String name;
  final String? flag;

  const Currency({
    required this.id,
    required this.uuid,
    required this.iso2Code,
    required this.iso3Code,
    required this.isActive,
    required this.name,
    required this.country,
    this.flag,
  });

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['id'] as int,
      uuid: map['uuid'] as String,
      iso2Code: map['iso2_code'] as String,
      iso3Code: map['iso3_code'] as String,
      isActive: map['is_active'] as bool,
      name: map['name'] as String,
      flag: map['icon'] != null ? map['icon'] as String : "assets/images/flags/Saudi-Arabia-Flag-icon.png",
      country: map['country'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return <Object>[
      id,
      uuid,
      iso2Code,
      iso3Code,
      isActive,
      name,
    ];
  }
}
