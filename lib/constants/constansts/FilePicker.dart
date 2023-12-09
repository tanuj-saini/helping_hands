import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<FilePickerResult?> pickkImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}
