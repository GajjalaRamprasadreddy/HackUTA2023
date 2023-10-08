

import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> _getFromGallery() async {
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxHeight:1800,
    maxWidth:1800,
  );
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    return imageFile;
  }
  return null;

}