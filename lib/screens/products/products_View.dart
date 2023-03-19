import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/products/product_Items/product_Item_View.dart';
import 'package:sales/screens/products/productrs_ViewModel.dart';
import 'package:sales/styles/colors.dart';

class Products_View extends StatefulWidget {
static const String routeName='Products';
  @override
  State<Products_View> createState() => _Products_ViewState();
}

class _Products_ViewState extends BaseView<Products_View,Products_ViewModel> implements Products_Naivagator{

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  var searchProductsController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
      appBar: AppBar(
        title: Text('Porducts',style: Theme.of(context).textTheme.headline1,),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, product_Item_View.routeName);
          }, icon: Icon(Icons.add))
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 45,
                    child: TextFormField(
                      onTap: (){
                        searchProductsController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: searchProductsController.text.length);
                      },
                      controller: searchProductsController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText:'Search' ,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: RODINACOLOR,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: RODINACOLOR,
                            )
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0
                        ),
                          onPressed: ()async{
                            await scanQRCode();
                          },
                          child: const Icon(Icons.qr_code_scanner,
                          color:RODINACOLOR,
                            size: 45,
                          ))),
                ),
                
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }



  @override
  Products_ViewModel initViewModel() {
    return Products_ViewModel();
  }

  @override
  Future scanQRCode()async {
    if(!Platform.isWindows){
      try {

        final qrCode = await FlutterBarcodeScanner.scanBarcode(
            '#ff6966', 'Cancel', true, ScanMode.QR);

        if (!mounted) return;

        setState(() {
           if (qrCode=='-1') {
             searchProductsController.text='';
             print(qrCode);
           }
           else{
             searchProductsController.text=qrCode;
           }
           print(qrCode);
              return;
        });

      } on PlatformException {

      }
    }
    else{
      try {
        setState(() {
          searchProductsController.text = 'ww';
        });

      } on PlatformException {
        searchProductsController.text = 'rr';
      }
    }

  }
}
