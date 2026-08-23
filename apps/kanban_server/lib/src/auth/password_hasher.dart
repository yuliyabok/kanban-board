// Password hasher для v1 backend. Пароль не хранится в plaintext: сохраняется
// salt и PBKDF2-HMAC-SHA256 hash. Legacy sha256 проверяется только для старых
// dev-записей.
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

final class PasswordHasher {
  const PasswordHasher({Uuid uuid = const Uuid()}) : _uuid = uuid;

  static const _algorithm = 'pbkdf2_sha256';
  static const _iterations = 120000;
  static const _keyLength = 32;

  final Uuid _uuid;

  String createSalt() => _uuid.v7();

  String hashPassword(String password, String salt) {
    final digest = _pbkdf2(password: password, salt: salt);
    return '$_algorithm\$_iterations\$${base64Url.encode(digest)}';
  }

  String hashToken(String token) {
    return sha256.convert(utf8.encode(token)).toString();
  }

  bool verifyPassword({
    required String password,
    required String salt,
    required String expectedHash,
  }) {
    if (expectedHash.startsWith('$_algorithm\$')) {
      return hashPassword(password, salt) == expectedHash;
    }

    return sha256.convert(utf8.encode('$salt:$password')).toString() ==
        expectedHash;
  }

  List<int> _pbkdf2({
    required String password,
    required String salt,
  }) {
    final hmac = Hmac(sha256, utf8.encode(password));
    final saltBytes = utf8.encode(salt);
    final blocks = <int>[];
    var blockIndex = 1;

    while (blocks.length < _keyLength) {
      final blockSalt = Uint8List(saltBytes.length + 4)
        ..setRange(0, saltBytes.length, saltBytes);
      ByteData.sublistView(blockSalt).setUint32(saltBytes.length, blockIndex);

      var u = hmac.convert(blockSalt).bytes;
      final output = List<int>.from(u);
      for (var i = 1; i < _iterations; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < output.length; j++) {
          output[j] ^= u[j];
        }
      }

      blocks.addAll(output);
      blockIndex++;
    }

    return blocks.take(_keyLength).toList(growable: false);
  }
}
