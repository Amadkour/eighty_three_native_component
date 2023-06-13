import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

String getHashedCode(String plainText) {
  var bytes1 = utf8.encode(plainText);
  return sha256.convert(bytes1).toString();
}

void encryption(String plainText, String newKey) {
  final key = Key.fromUtf8(newKey);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  encrypter.encrypt(plainText, iv: iv);
}

void descryption(String encryptionText, String newKey) {
  final key = Key.fromUtf8(newKey);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  encrypter.decrypt(Encrypted.fromUtf8(encryptionText), iv: iv);
}
