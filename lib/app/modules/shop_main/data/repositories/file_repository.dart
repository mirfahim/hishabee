import 'dart:io';

import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/file_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';

class FileRepository implements IFileRepository {
  final IFileProvider fileProvider;

  FileRepository(this.fileProvider);

  @override
  Future<String> uploadFile({File file, String type}) async {
    final response = await fileProvider.uploadFile(file: file, type: type);
    return response /*ResponseDecoder.decode(response)*/;
  }
}
