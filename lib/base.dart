
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









  }

