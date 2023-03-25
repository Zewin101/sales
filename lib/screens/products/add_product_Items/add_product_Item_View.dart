import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';


import 'package:sales/shared/network/remote/firebase_Utils.dart';
import 'package:sales/styles/colors.dart';
import '../../../generated/assets.dart';
import '../../../shared/componant/componants.dart';
import '../models_products/category_products.dart';
import 'add_product_Item_ViewModel.dart';

class product_Item_View extends StatefulWidget {
  static const String routeName = 'ProductItem';

  @override
  State<product_Item_View> createState() => _product_Item_ViewState();
}

class _product_Item_ViewState
    extends BaseView<product_Item_View, Products_Item_ViewModel>
    implements Products_Item_Naivagator {

  late String dropdownValue;
  var formKey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    // dropdownValue = viewModel.categoryProductsItems[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            Assets.imageBack,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(

            /// chang image
            appBar: AppBar(
              title: Text('New Product'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_sharp)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () async {
                            chooseCameraOrGallery();

                            // await getFromGallery();
                          },
                          child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.15,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.30,
                            decoration: BoxDecoration(
                              border: Border.all(color: RODINACOLOR, width: 3),
                              borderRadius: BorderRadius.circular(10),
                              // image:DecorationImage(
                              //   image:  AssetImage(Assets.imageBackground),)
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: viewModel.image != null
                                ? Container(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.15,
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: RODINACOLOR, width: 3),
                                borderRadius: BorderRadius.circular(10),
                                // image:DecorationImage(
                                //   image:  AssetImage(Assets.imageBackground),)
                              ),
                              child: Image.file(
                                viewModel.image!,
                                fit: BoxFit.fill,
                              ),
                            )
                                : Center(child: Icon(Icons.camera_alt,size: MediaQuery.of(context).size.width*.15,color: RODINACOLOR,)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.trim() == '') {
                              return 'name product';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onTap: () {
                            viewModel.nameController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset:
                                viewModel.nameController.text.length);
                          },
                          controller: viewModel.nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name *',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: RODINACOLOR,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: RODINACOLOR,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 45,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value.trim() == '') {
                                    return 'scan code';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onTap: () {
                                  viewModel.codeController.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: viewModel
                                              .codeController.text.length);
                                },
                                controller: viewModel.codeController,
                                decoration: const InputDecoration(
                                  labelText: 'code *',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
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
                                        elevation: 0),
                                    onPressed: () async {
                                      await scanQRCode();
                                    },
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: RODINACOLOR,
                                      size: 45,
                                    ))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 45,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.trim() == '') {
                              return 'choose Category';
                            }
                            return null;
                          },
                          readOnly: true,
                          keyboardType: TextInputType.none,
                          cursorColor: Colors.redAccent,
                          onTap: () async {
                            ShowBottomSheet();

                            setState(() {});
                          },
                          controller: viewModel.categoryController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            labelText: 'Category',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: RODINACOLOR,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: RODINACOLOR,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      /// Price
                      Row(
                        children: [
                          Text(
                            'buy price: *',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 45,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value.trim() == '') {
                                    return 'price';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (viewModel.quantityController.text.isEmpty) {
                                    viewModel.quantityController.text = '1';
                                    double total = double.parse(value) *
                                        double.parse(
                                            viewModel.quantityController.text);
                                    viewModel.totalController.text =
                                        total.toString();
                                  } else {
                                    double total = double.parse(value) *
                                        double.parse(
                                            viewModel.quantityController.text);
                                    viewModel.totalController.text =
                                        total.toString();
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onTap: () {
                                  viewModel.priceBuyController.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: viewModel
                                              .priceBuyController.text.length);
                                },
                                controller: viewModel.priceBuyController,
                                decoration: const InputDecoration(
                                  hintText: '0.00',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'price Selling: *',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 45,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value.trim() == '') {
                                    return 'price';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onTap: () {
                                  viewModel.priceSellController.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: viewModel
                                              .priceSellController.text.length);
                                },
                                controller: viewModel.priceSellController,
                                decoration: const InputDecoration(
                                  hintText: '0.00',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      ///Quantity
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Quantity: *',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              )),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 45,
                              child: TextFormField(

                                onChanged: (value) {
                                  double total = double.parse(
                                      viewModel.priceSellController.text) *
                                      double.parse(value);
                                  viewModel.totalController.text =
                                      total.toString();
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onTap: () {
                                  viewModel.priceSellController.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: viewModel
                                              .priceSellController.text.length);
                                },
                                controller: viewModel.quantityController,
                                decoration: const InputDecoration(
                                  hintText: '1',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text('Total: *',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(

                                    ///COLOR TOTAL NEED TO CHANGE
                                      fontWeight: FontWeight.bold,
                                      color: RODINACOLOR))),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 45,
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                onTap: () {
                                  viewModel.totalController.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: viewModel
                                              .totalController.text.length);
                                },
                                controller: viewModel.totalController,
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: RODINACOLOR,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .07,
                        child: DefaultElevatedButton(
                            widgets: [
                              Text(
                                "Add Product ",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1,
                              ),
                              const Icon(Icons.keyboard_double_arrow_down),
                            ],
                            onPressed: () async {

                             await addProductValid();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Products_Item_ViewModel initViewModel() {
    return Products_Item_ViewModel();
  }

  Future addProductValid() async {
    if (formKey.currentState!.validate()) {
      await viewModel.getImagePath();
      await viewModel.addProductInFirestore(
          productName: viewModel.nameController.text,
          code: viewModel.codeController.text,
          category: viewModel.categoryController.text,
          sellingPrice:
          viewModel.priceSellController.text,
          priceBuy:
          viewModel.priceBuyController.text,
          quantity:
          viewModel.quantityController.text);
    }
  }


  @override
  Future scanQRCode() async {
    if (!Platform.isWindows) {
      try {
        final qrCode = await FlutterBarcodeScanner.scanBarcode(
            '#ff6966', 'Cancel', true, ScanMode.QR);
        if (!mounted) return;

        setState(() {
          if (qrCode == '-1') {
            viewModel.codeController.text = '';
            print(qrCode);
          } else {
            viewModel.codeController.text = qrCode;
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

  Future getFromGallery() async {
    if (!Platform.isWindows) {
      try {
        final image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        viewModel.image = imagePath;
        print("---------------------------------${viewModel.image}");
        // viewModel.getImagePath();
        setState(() {});
        Navigator.pop(context);
      } on PlatformException catch (e) {
        print('filed to pick image : $e');
      }
    } else {
      try {
        final image = await FilePicker.platform.pickFiles();
        if (image == null) return;
        // final imagePath = File(image.files);
        // this.image = imagePath;
        setState(() {});
        Navigator.pop(context);
      } on PlatformException catch (e) {
        print('filed to pick image : $e');
      }
    }
  }

  Future getFromCamera() async {
    if (!Platform.isWindows) {
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image == null) return;
        final imagePath = File(image.path);
        viewModel.image = imagePath;
        // viewModel.getImagePath();
        setState(() {});
        Navigator.pop(context);
      } on PlatformException catch (e) {
        print('filed to pick image : $e');
      }
    }
  }

  void chooseCameraOrGallery() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: RODINACOLOR,
            title: Text(
              'Select Image source',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1,
            ),
            content: !Platform.isWindows
                ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await getFromGallery();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, elevation: 0),
                  child: Row(
                    children: [
                      const Icon(Icons.photo_library_sharp,
                          color: Colors.white),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Gallery',
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await getFromCamera();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, elevation: 0),
                  child: Row(
                    children: [
                      const Icon(Icons.camera, color: Colors.white),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Camera',
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.image = null;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, elevation: 0),
                  child: Row(
                    children: [
                      const Icon(Icons.close, color: Colors.white),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Delete',
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : ElevatedButton(
              onPressed: () {
                viewModel.image = null;
                setState(() async {
                  await getFromGallery();
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, elevation: 0),
              child: Row(
                children: [
                  const Icon(Icons.close, color: Colors.white),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'choose image',
                    style:
                    Theme
                        .of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void ShowBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.35,
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder<QuerySnapshot<CategoryProducts>>(
                    future: FirebaseUtils
                        .readAllCategoryFromFirebaseFirestore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error ${snapshot.error}');
                      }
                      var allCatrgory = snapshot.data!.docs.map((e) => e.data())
                          .toList();
                      return ListView.builder(
                        itemCount: allCatrgory.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: index.isOdd ? RODINACOLOR2 : RODINACOLOR3,
                            margin: EdgeInsets.symmetric(vertical: 6),
                            height: 45,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.none,
                              onTap: () {
                                viewModel.categoryController.text =
                                    allCatrgory[index].nameCategory;
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                  text: allCatrgory[index].nameCategory),
                              decoration: InputDecoration(
                                prefixIcon: Radio(
                                    value: allCatrgory[index],
                                    groupValue: allCatrgory,
                                    onChanged: (value) {
                                      allCatrgory[index].nameCategory =
                                          value.toString();
                                    }),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: RODINACOLOR,
                                    )),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: RODINACOLOR,
                                    )),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .07,
                child: DefaultElevatedButton(
                    widgets: [
                      Icon(Icons.add),
                      Text(
                        "Add new category ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline1,
                      ),
                    ],
                    onPressed: () {
                      setState(() {});
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'add category',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                              content: TextField(
                                keyboardType: TextInputType.text,
                                controller: viewModel.addCategoryController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: DefaultElevatedButton(
                                          widgets: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              "save ",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline1,
                                            ),
                                          ],
                                          onPressed: () async {

                                            /// read category--------------///
                                            String categoryName = viewModel
                                                .addCategoryController.text;
                                            viewModel.addCategoryInFirestore(
                                                categoryName: categoryName);
                                            viewModel.addCategoryInList();
                                            viewModel.addCategoryController
                                                .clear();
                                            setState(() {});
                                            Navigator.pop(context);
                                          }),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
