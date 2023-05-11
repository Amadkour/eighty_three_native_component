abstract class Failure {
  String? hint;

  final int? code;
  final String? resourceName;
  Map<String, dynamic> errors = <String, dynamic>{};

  String get message => errors.values.join(', ');

  Failure({this.code, this.resourceName, this.hint});
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({super.code, super.resourceName});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.code, super.resourceName}) {
    errors = <String, String>{'': 'no_network'};
  }
}

class GeneralFailure extends Failure {
  GeneralFailure({Map<String, dynamic>? errors, String? message})
      : super(hint: message) {
    if (errors != null) {
      this.errors = errors;
    } else {
      this.errors = <String, String>{"": "General Errors"};
    }
  }
}

class ApiFailure extends Failure {
  ApiFailure({
    super.code,
    super.resourceName,
    Map<String, dynamic>? errors,
    String? hint,
  }) {
    errors ??= <String, String>{'': 'server error'};
    this.errors = errors;
    this.hint = hint;
  }
}

class OtpVerificationFailure extends Failure {
  final String otp;

  OtpVerificationFailure(this.otp);
}
