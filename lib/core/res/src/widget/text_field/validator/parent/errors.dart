import 'dart:convert';

import 'package:flutter/services.dart';

class ValidationError {
  ValidationError() {
    loadErrors();
  }

  Future<void> loadErrors() async {
    errors = json.decode(await rootBundle.loadString(0 == 0 ? 'assets/errors/ar.json' : 'assets/errors/en.json'))
        as Map<String, String>;
  }

  Map<String,String> errors = <String,String>{};
}
