import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ProjectVault {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> saveFile(String filename, String content) async {
    final path = await _localPath;
    final file = File('$path/$filename');
    // Dizini oluştur (Eğer yoksa)
    await file.create(recursive: true);
    return file.writeAsString(content);
  }
}
