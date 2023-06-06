import 'package:eighty_three_native_component/core/res/src/permissions/permission.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eighty_three_native_component/core/res/src/services/firebase/firebase_analytics_service.dart';

class FirebaseEvents {
  final FirebaseAnalyticsService _firebaseAnalyticsService;

  FirebaseEvents(this._firebaseAnalyticsService);

  void logRegistrationEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("registration_event", parameters: <String, dynamic>{
      'phone': parameters['phone'],
      'email': parameters['email'],
      'identity': parameters['identity_id']
    });
  }

  void logLoginEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("login_event", parameters: parameters);
  }

  void logRealStateInvestment({required int? realEstateId, required String? amount}) {
    _firebaseAnalyticsService.logEvent("real_state_invest_event", parameters: <String, dynamic>{
      "realEstateId": realEstateId ?? 0,
      "amount": amount ?? "",
    });
  }

  void logUpgradeAccountEvent({required Map<String, dynamic> parameters}) {
    final List<String> codes = <String>[];
    final List<MultipartFile> files = <MultipartFile>[];

    // for (final SingleProfessionalInvestor i in attachments) {
    //   codes.add(i.code!);
    //   files.add(MultipartFile(i.file!.openRead(), i.file!.lengthSync(),
    //       filename: i.file!.path.split('/').last));
    // }
    _firebaseAnalyticsService.logEvent("add_new_bank_account_event", parameters:
    <String, dynamic>{
      "user": currentUserPermission.toMap(),
      'codes[]': codes,
      'attachments[]': files
    });
  }

  void logRequestLoan({
    required String propertyId,
  }) {
    _firebaseAnalyticsService.logEvent("create_loan_event", parameters: <String, dynamic>{
      'property_id': propertyId,
      'name': currentUserPermission.name,
      'user_id': currentUserPermission.identityId
    });
  }

  void logCancelLoan() {
    _firebaseAnalyticsService.logEvent("cancel_loan_event", parameters: <String, dynamic>{
      'token': currentUserPermission.token,
      'email': currentUserPermission.email,
      'name': currentUserPermission.name
    });
  }

  void logPayLoan() {
    _firebaseAnalyticsService.logEvent("pay_loan_event", parameters: <String, dynamic>{
      'token': currentUserPermission.token,
      'email': currentUserPermission.email,
      'name': currentUserPermission.name
    });
  }

  void logChargeCreditCardEvent(
      {required String cardName,
        required String cardNumber,
        required String paymentMethodId,
        required String cvv,
        required String expireYear,
        required String expireMonth,
        required String cardAmount,
        required int saveCredit}) {
    _firebaseAnalyticsService.logEvent("charge_credit_card_event", parameters: <String, dynamic>{
      'holder_name': cardName,
      'card_number': cardNumber,
      'payment_method_id': paymentMethodId,
      'expiry[year]': expireYear,
      'expiry[month]': expireMonth,
      'save_credit': saveCredit,
      'cvv': cvv,
      'amount': cardAmount,
    });
  }

  void logAddAmountCreditCardEvent({
    required int cardId,
    required String amount,
    required String cardName,
  }) {
    _firebaseAnalyticsService
        .logEvent("add_amount_to_credit_card_event", parameters: <String, dynamic>{
      'card_id': cardId,
      'amount': amount,
      'holder_name': cardName,
    });
  }

  void logAddNewCreditCardEvent({
    required String cardName,
    required String cardNumber,
    required String paymentMethodId,
    required String expireYear,
    required String cvv,
    required String expireMonth,
  }) {
    _firebaseAnalyticsService.logEvent("add_new_credit_card_event", parameters: <String, dynamic>{
      'holder_name': cardName,
      'card_number': cardNumber,
      'payment_method_id': paymentMethodId,
      'cvv': cvv,
      'expiry[year]': expireYear,
      'expiry[month]': expireMonth,
    });
  }

  void logDeleteCreditCardEvent({required int cardId}) {
    _firebaseAnalyticsService.logEvent("delete_credit_card_event", parameters: <String, dynamic>{
      'card_id': cardId,
    });
  }

  void logWithdrawalAmountFromWalletEvent({
    String? amount,
    int? bankAccountId,
    String? confirmationCode,
  }) {
    _firebaseAnalyticsService
        .logEvent("withdrawal_amount_from_wallet_event", parameters: <String, dynamic>{
      'bank_account_id': bankAccountId,
      'amount': amount,
      'confirmation_code': confirmationCode,
    });
  }

  void logAddNewBankAccountEvent({
    String? accountNumber,
    int? bankId,
    String? holderName,
    String? iban,
    String? code,
  }) {
    _firebaseAnalyticsService.logEvent("add_new_bank_account_event", parameters: <String, dynamic>{
      'account_number': accountNumber,
      'bank_id': bankId,
      'holder_name': holderName,
      'iban': iban,
      'confirmation_code': code,
      'country_id': 1
    });
  }

  void logEditBankAccountEvent(
      {required String accountNumber,
        required int bankId,
        required String holderName,
        required String iban,
        required int id,
        required String code}) {
    _firebaseAnalyticsService.logEvent("edit_bank_account_event", parameters: <String, dynamic>{
      'country_id': 1,
      'account_number': accountNumber,
      'bank_id': bankId,
      'holder_name': holderName,
      'iban': iban,
      'bank_account_id': id,
    });
  }

  Future<void> logEditProfileEvent({
    String? phone,
    String? email,
    String? countryId,
    String? nationalID,
    String? name,
    File? image,
    File? staying,
    File? passport,
  }) async {
    _firebaseAnalyticsService.logEvent("edit_profile_event", parameters: <String, dynamic>{
      'phone_number': phone,
      'full_name': name,
      'email': email,
      'identity_id': nationalID,
      'country_id': countryId,
      if (image!.path != '')
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      if (passport!.path != '')
        'passport': await MultipartFile.fromFile(
          passport.path,
          filename: passport.path.split('/').last,
        ),
      if (staying!.path != '')
        'stay': await MultipartFile.fromFile(
          staying.path,
          filename: staying.path.split('/').last,
        )
    });
  }
}
