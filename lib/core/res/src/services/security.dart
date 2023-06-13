import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

String getHashedCode(String plainText) {
  var bytes1 = utf8.encode(plainText);
  return sha256.convert(bytes1).toString();
}

Encrypted encryption(String plainText, String newKey) {
  final key = Key.fromUtf8(newKey);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted;
}

String descryption(String encryptionText, String newKey) {
  final key = Key.fromUtf8(newKey);
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  String decryption =
      encrypter.decrypt(Encrypted.fromUtf8(encryptionText), iv: iv);
  return decryption;
}
