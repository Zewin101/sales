//
//
//
//
//
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
// Future getFromGallery() async {
//   if (!Platform.isWindows) {
//     try {
//       final image =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//       var imagePath = File(image.path);
//       var image1 = basename(imagePath).toString();
//       var
//       print("---------------------------------${}");
//
//       // setState(() {});
//       // Navigator.pop(context);
//     } on PlatformException catch (e) {
//       print('filed to pick image : $e');
//     }
//   } else {
//     try {
//       final image = await FilePicker.platform.pickFiles();
//       if (image == null) return;
//       // final imagePath = File(image.files);
//       // this.image = imagePath;
//       // setState(() {});
//       // Navigator.pop(context);
//     } on PlatformException catch (e) {
//       print('filed to pick image : $e');
//     }
//   }
// }