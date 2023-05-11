// ignore_for_file: public_member_api_docs, sort_constructors_first
LoggedInUser loggedInUser = LoggedInUser();

class LoggedInUser {
  String? name;
  String? uuid;
  String? phone;
  bool? isFaceIdActive;
  bool? isTouchIdActive;
  String? identityId;
  String? email;
  String? locale;
  bool? isVerified;
  String? pinCode;
  String? image;
  String? token;
  String? country;
  String? currency;

  LoggedInUser({
    this.name,
    this.uuid,
    this.phone,
    this.country,
    this.currency,
    this.isFaceIdActive,
    this.isTouchIdActive,
    this.identityId,
    this.email,
    this.locale,
    this.isVerified,
    this.token,
    this.pinCode,
    this.image,
  });

  factory LoggedInUser.fromMap(Map<String, dynamic> map) {
    return LoggedInUser(
      name: map['full_name'] as String,
      phone: map['phone_number'] as String,
      uuid: map['uuid'].toString(),
      isFaceIdActive: map['is_active'] as bool,
      isTouchIdActive: map['touch_id_active'] as bool,
      email: map['email'] as String,
      identityId: map['identity_id'].toString(),
      isVerified: map['is_verified'] as bool,
      locale: map['locale'] as String,
      token: map['token'] as String,
      image: map['image'] as String?,
      pinCode: map['pin_code'] as String?,
      country: map['country'] as String?,
      currency: map['currency'] as String?,
    );
  }
  bool get isArabic => locale == 'ar';
}
