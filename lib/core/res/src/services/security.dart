import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String getHashedCode(String plainText) {
  var bytes1 = utf8.encode(plainText);
  return sha256.convert(bytes1).toString();
}

String encryption(String keyName) {
  final key = enc.Key.fromUtf8(dotenv.env['ENCRYPT_KEY'] ?? "");
  final iv = enc.IV.fromUtf8(dotenv.env['ENCRYPT_IV_KEY'] ?? "");

  final encrypter =
      enc.Encrypter(enc.AES(key, mode: enc.AESMode.ctr, padding: null));
  final encrypted = encrypter.encrypt(keyName, iv: iv);
  final ciphertext = encrypted.base64;

  return ciphertext;
}

String decryption(String encryptionText) {
  final key = enc.Key.fromUtf8(dotenv.env['ENCRYPT_KEY'] ?? "");
  final iv = enc.IV.fromUtf8(dotenv.env['ENCRYPT_IV_KEY'] ?? "");
  final decrypter =
      enc.Encrypter(enc.AES(key, mode: enc.AESMode.ctr, padding: null));
  final decrypted =
      decrypter.decryptBytes(enc.Encrypted.fromBase64(encryptionText), iv: iv);
  final decryptedData = utf8.decode(decrypted);

  return decryptedData;
}
