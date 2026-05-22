import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../device_storage.dart';

DeviceStorage createDeviceStorage() => const FileDeviceStorage();

final class FileDeviceStorage implements DeviceStorage {
  const FileDeviceStorage();

  static const _fileName = 'device_storage.json';

  @override
  Future<String?> read(String key) async {
    final values = await _readValues();
    return values[key];
  }

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {
    final values = await _readValues();
    values[key] = value;
    await _writeValues(values);
  }

  @override
  Future<void> delete(String key) async {
    final values = await _readValues();
    values.remove(key);
    await _writeValues(values);
  }

  Future<Map<String, String>> _readValues() async {
    final file = await _file();
    if (!file.existsSync()) {
      return {};
    }

    final decoded = jsonDecode(await file.readAsString());
    if (decoded is! Map<String, dynamic>) {
      return {};
    }

    return decoded.map((key, value) => MapEntry(key, value as String));
  }

  Future<void> _writeValues(Map<String, String> values) async {
    final file = await _file();
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(values), flush: true);
  }

  Future<File> _file() async {
    final directory = await getApplicationSupportDirectory();
    return File(path.join(directory.path, _fileName));
  }
}
