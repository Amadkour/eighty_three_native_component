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
      'identity': parameters['identity']
    });
  }

  void logLoginEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("login_event", parameters: parameters);
  }

  void logRealStateInvestment({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("real_state_invest_event", parameters:parameters);
  }

  void logUpgradeAccountEvent({required Map<String, dynamic> parameters}) {


    _firebaseAnalyticsService.logEvent("add_new_bank_account_event", parameters:parameters);
  }

  void logRequestLoan({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("create_loan_event", parameters: parameters);
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
      {required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("charge_credit_card_event", parameters: parameters);
  }

  void logAddAmountCreditCardEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService
        .logEvent("add_amount_to_credit_card_event", parameters: parameters);
  }

  void logAddNewCreditCardEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("add_new_credit_card_event", parameters: parameters);
  }

  void logDeleteCreditCardEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("delete_credit_card_event", parameters:parameters);
  }

  void logWithdrawalAmountFromWalletEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService
        .logEvent("withdrawal_amount_from_wallet_event", parameters:parameters);
  }

  void logAddNewBankAccountEvent({required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("add_new_bank_account_event", parameters: parameters);
  }

  void logEditBankAccountEvent(
      {required Map<String, dynamic> parameters}) {
    _firebaseAnalyticsService.logEvent("edit_bank_account_event", parameters: parameters);
  }

  Future<void> logEditProfileEvent({required Map<String, dynamic> parameters}) async {
    _firebaseAnalyticsService.logEvent("edit_profile_event", parameters: parameters);
  }
}
