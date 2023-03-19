import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';

import 'package:sales/screens/products/product_Items/product_Item_ViewModel.dart';
import 'package:sales/styles/colors.dart';
import '../../../shared/componant/componants.dart';

class product_Item_View extends StatefulWidget {
  static const String routeName = 'ProductItem';

  @override
  State<product_Item_View> createState() => _product_Item_ViewState();
}

class _product_Item_ViewState
    extends BaseView<product_Item_View, Products_Item_ViewModel>
    implements Products_Item_Naivagator {
  File? image;
  late String dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    dropdownValue = viewModel.categoryProductsItems[0];
  }

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create: (context) => viewModel,
    child:Scaffold(
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
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.30,
                    decoration: BoxDecoration(
                      border: Border.all(color: RODINACOLOR, width: 3),
                      borderRadius: BorderRadius.circular(10),
                      // image:DecorationImage(
                      //   image:  AssetImage(Assets.imageBackground),)
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: image != null
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                              border: Border.all(color: RODINACOLOR, width: 3),
                              borderRadius: BorderRadius.circular(10),
                              // image:DecorationImage(
                              //   image:  AssetImage(Assets.imageBackground),)
                            ),
                            child: Image.file(
                              image!,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Center(child: Icon(Icons.camera_alt)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    viewModel.nameController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: viewModel.nameController.text.length);
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
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          viewModel.codeController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset:
                                  viewModel.codeController.text.length);
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

              ///dropDown----------------
              // DropdownButtonFormField(
              //     decoration: const InputDecoration(
              //       hintText: 'code *',
              //       focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //             color: RODINACOLOR,
              //           )),
              //       enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //             color: RODINACOLOR,
              //           )),
              //     ),
              //     value: dropdownValue,
              //     items: viewModel.categoryProductsItems
              //         .map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         dropdownValue = newValue!;
              //       });
              //     }),
              ///dropDown----------------
              Container(
                height: 45,
                child: TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.none,
                  cursorColor: Colors.redAccent,
                  onTap: () {
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
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Price: *',
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 45,
                      child: TextFormField(
                        onChanged: (value) {
                          if (viewModel.quantityController.text.isEmpty) {
                            viewModel.quantityController.text = '1';
                            int total = int.parse(value) *
                                int.parse(viewModel.quantityController.text);
                            viewModel.totalController.text = total.toString();
                          } else {
                            int total = int.parse(value) *
                                int.parse(viewModel.quantityController.text);
                            viewModel.totalController.text = total.toString();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          viewModel.priceController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset:
                                  viewModel.priceController.text.length);
                        },
                        controller: viewModel.priceController,
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
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Quantity: *',
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 45,
                      child: TextFormField(
                        onChanged: (value) {
                          int total =
                              int.parse(viewModel.priceController.text) *
                                  int.parse(value);
                          viewModel.totalController.text = total.toString();
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          viewModel.priceController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset:
                                  viewModel.priceController.text.length);
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
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(

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
                          viewModel.totalController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset:
                                  viewModel.totalController.text.length);
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
                height: MediaQuery.of(context).size.height * .07,
                child: DefaultElevatedButton(widgets: [
                  Text(
                    "Add Product ",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const Icon(Icons.keyboard_double_arrow_down),
                ], onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  @override
  Products_Item_ViewModel initViewModel() {
    return Products_Item_ViewModel();
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
        this.image = imagePath;
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
        this.image = imagePath;
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
              style: Theme.of(context).textTheme.headline1,
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
                              style: Theme.of(context)
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
                              style: Theme.of(context)
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
                          image = null;
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
                              style: Theme.of(context)
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
                      image = null;
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
                              Theme.of(context).textTheme.subtitle1?.copyWith(
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
          height: MediaQuery.of(context).size.height * 0.35,
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.categoryProductsItems.length,
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
                              viewModel.categoryProductsItems[index];
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        readOnly: true,
                        controller: TextEditingController(
                            text: viewModel.categoryProductsItems[index]),
                        decoration: InputDecoration(
                          prefixIcon: Radio(
                              value: viewModel.categoryProductsItems[index],
                              groupValue: viewModel.categoryProductsItems,
                              onChanged: (value) {
                                viewModel.categoryProductsItems[index] =
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
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .07,
                child: DefaultElevatedButton(
                    widgets: [
                      Icon(Icons.add),
                      Text(
                        "Add new category ",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                    onPressed: () {
                      viewModel.addCategory.text = '';
                      setState(() {});
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'add category',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              content: TextField(
                                keyboardType: TextInputType.text,
                                controller: viewModel.addCategory,
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
                                            ),
                                          ],
                                          onPressed: () {
                                            viewModel.addCategoryInList();
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
