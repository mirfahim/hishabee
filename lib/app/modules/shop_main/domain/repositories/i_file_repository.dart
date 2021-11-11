import 'dart:io';

abstract class IFileRepository {
  Future<String> uploadFile({File file, String type});
}
