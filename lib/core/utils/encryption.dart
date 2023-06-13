// import 'package:encrypt/encrypt.dart' ;
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// class EncryptClass{
//   String encryptAES(String plainText, String key) {
//     final plainTextBytes = utf8.encode(plainText);
//     final keyBytes = utf8.encode(key);
//     final keyHash = sha256.convert(keyBytes).bytes;
//     final iv = IV.fromLength(16); // Generate a random IV
//
//     final encrypter = Encrypter(AES(Key(keyHash)));
//
//     final encrypted = encrypter.encryptBytes(plainTextBytes, iv: iv);
//
//     // Return the encrypted data as a base64-encoded string
//     return base64.encode(encrypted.bytes);
//   }
//
//
//   String decryptAES(String encryptedText, String key) {
//     final keyBytes = base64.decode(key);
//     final iv = IV.fromLength(16); // Must be the same IV used for encryption
//
//     final encrypter = Encrypter(AES(Key(keyBytes)));
//
//     final encrypted = Encrypted.fromBase64(encryptedText);
//     final decrypted = encrypter.decrypt(encrypted, iv: iv);
//
//     // Return the decrypted data
//     return decrypted;
//   }
// }