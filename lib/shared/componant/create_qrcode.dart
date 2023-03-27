



import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class CreateQrCode extends StatelessWidget {
  String value;
  bool showValue;
  Symbology symbology;

  CreateQrCode(
      {required this.value, required this.showValue, required this.symbology});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: SfBarcodeGenerator(
        value: value,
        symbology: symbology,
        showValue: showValue,
      ),
    );
  }
}