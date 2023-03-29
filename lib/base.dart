
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales/styles/colors.dart';

abstract class BaseNavigator {
  void showLoading({String message});
  void showMessage(String message);
  void hideLoading();
  Future scanQRCode1(String textController) ;
  // Future getFromGallery();
  // Future getFromCamera();
  // void chooseCameraOrGallery();


}

class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
NAV? navigator=null;

}

 abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator{
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }
  @override
  void hideLoading() {
    Navigator.pop(context);
  }
  @override
  void showLoading({String message = "Loading..."}) {
    showDialog(

      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: RODINACOLOR,
          title: Center(child: Container(
            color:  RODINACOLOR,
            child: Row(
              children: [
                Text(message,style:  Theme.of(context).textTheme.headline1,),
                const SizedBox(
                  width: 15,
                ),

                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          )),
        );
      },
    );
  }
  @override
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: RODINACOLOR,
          content: Text(message,style: Theme.of(context).textTheme.headline1,),

        );
      },
    );
  }
  @override
  Future scanQRCode1(String textController) async{

      if (!Platform.isWindows) {
        try {
          final qrCode = await FlutterBarcodeScanner.scanBarcode(
              '#ff6966', 'Cancel', true, ScanMode.QR);
          if (!mounted) return;

          setState(() {
            if (qrCode == '-1') {
              textController = '';
              print(qrCode);
            } else {
              textController = qrCode;
            }
            print(qrCode);
            return;
          });
        } on PlatformException {}
      } else {
        try {
          setState(() {});
        } on PlatformException {}
      }
    }



 //  @override
 //  void chooseCameraOrGallery() {
 //    showDialog(
 //        context: context,
 //        builder: (context) {
 //          return AlertDialog(
 //            backgroundColor: RODINACOLOR,
 //            title: Text(
 //              'Select Image source',
 //              style: Theme
 //                  .of(context)
 //                  .textTheme
 //                  .headline1,
 //            ),
 //            content: !Platform.isWindows
 //                ? Column(
 //              mainAxisSize: MainAxisSize.min,
 //              children: [
 //                ElevatedButton(
 //                  onPressed: () async {
 //                    await getFromGallery();
 //                  },
 //                  style: ElevatedButton.styleFrom(
 //                      backgroundColor: Colors.transparent, elevation: 0),
 //                  child: Row(
 //                    children: [
 //                      const Icon(Icons.photo_library_sharp,
 //                          color: Colors.white),
 //                      const SizedBox(
 //                        width: 30,
 //                      ),
 //                      Text(
 //                        'Gallery',
 //                        style: Theme
 //                            .of(context)
 //                            .textTheme
 //                            .subtitle1
 //                            ?.copyWith(color: Colors.white),
 //                      ),
 //                    ],
 //                  ),
 //                ),
 //                const SizedBox(
 //                  height: 20,
 //                ),
 //                ElevatedButton(
 //                  onPressed: () async {
 //                    await getFromCamera();
 //                  },
 //                  style: ElevatedButton.styleFrom(
 //                      backgroundColor: Colors.transparent, elevation: 0),
 //                  child: Row(
 //                    children: [
 //                      const Icon(Icons.camera, color: Colors.white),
 //                      const SizedBox(
 //                        width: 30,
 //                      ),
 //                      Text(
 //                        'Camera',
 //                        style: Theme
 //                            .of(context)
 //                            .textTheme
 //                            .subtitle1
 //                            ?.copyWith(
 //                          color: Colors.white,
 //                        ),
 //                      ),
 //                    ],
 //                  ),
 //                ),
 //                const SizedBox(
 //                  height: 20,
 //                ),
 //                ElevatedButton(
 //                  onPressed: () {
 //                    viewModel.image = null;
 //                    setState(() {});
 //                    Navigator.pop(context);
 //                  },
 //                  style: ElevatedButton.styleFrom(
 //                      backgroundColor: Colors.transparent, elevation: 0),
 //                  child: Row(
 //                    children: [
 //                      const Icon(Icons.close, color: Colors.white),
 //                      const SizedBox(
 //                        width: 30,
 //                      ),
 //                      Text(
 //                        'Delete',
 //                        style: Theme
 //                            .of(context)
 //                            .textTheme
 //                            .subtitle1
 //                            ?.copyWith(
 //                          color: Colors.white,
 //                        ),
 //                      ),
 //                    ],
 //                  ),
 //                ),
 //              ],
 //            )
 //                : ElevatedButton(
 //              onPressed: () {
 //                viewModel.image = null;
 //                setState(() async {
 //                  await getFromGallery();
 //                });
 //              },
 //              style: ElevatedButton.styleFrom(
 //                  backgroundColor: Colors.transparent, elevation: 0),
 //              child: Row(
 //                children: [
 //                  const Icon(Icons.close, color: Colors.white),
 //                  const SizedBox(
 //                    width: 30,
 //                  ),
 //                  Text(
 //                    'choose image',
 //                    style:
 //                    Theme
 //                        .of(context)
 //                        .textTheme
 //                        .subtitle1
 //                        ?.copyWith(
 //                      color: Colors.white,
 //                    ),
 //                  ),
 //                ],
 //              ),
 //            ),
 //          );
 //        });
 //  }
 //
 //  @override
 //  Future getFromCamera()async{
 //    if (!Platform.isWindows) {
 //      try {
 //        final image = await ImagePicker().pickImage(source: ImageSource.camera);
 //        if (image == null) return;
 //        final imagePath = File(image.path);
 //        viewModel.image = imagePath;
 //        // viewModel.getImagePath();
 //        setState(() {});
 //        Navigator.pop(context);
 //      } on PlatformException catch (e) {
 //        print('filed to pick image : $e');
 //      }
 //    }
 //  }
 //
 //  @override
 // getFromGallery(File? imagde) async{
 //    if (!Platform.isWindows) {
 //      try {
 //        final image =
 //            await ImagePicker().pickImage(source: ImageSource.gallery);
 //        if (image == null) return;
 //        final imagePath = File(image.path);
 //       imagde= imagePath;
 //        print("---------------------------------${viewModel.image}");
 //        // viewModel.getImagePath();
 //        setState(() {});
 //        Navigator.pop(context);
 //      } on PlatformException catch (e) {
 //        print('filed to pick image : $e');
 //      }
 //    } else {
 //      try {
 //        final image = await FilePicker.platform.pickFiles();
 //        if (image == null) return;
 //        // final imagePath = File(image.files);
 //        // this.image = imagePath;
 //        setState(() {});
 //        Navigator.pop(context);
 //      } on PlatformException catch (e) {
 //        print('filed to pick image : $e');
 //      }
 //    }
 //  }





  }

