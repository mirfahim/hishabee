import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File> getImageFromGallery() async {
    File _image;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    return _image;
  }

  static Future<File> getImageFromCamera() async {
    File _image;
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e.message);
    }
    return _image;
  }
}
