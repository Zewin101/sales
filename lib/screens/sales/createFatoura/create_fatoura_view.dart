import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/json/jsonP.dart';
import 'package:sales/shared/componant/componants.dart';
import 'package:sales/styles/colors.dart';
import '../invoices/invoices_View.dart';
import 'create_fatoura_ViewModel.dart';

class Sales_Screen_View extends StatefulWidget {
  static const String routeName = 'sales_Screen';

  @override
  State<Sales_Screen_View> createState() => _Sales_ViewState();
}

class _Sales_ViewState
    extends BaseView<Sales_Screen_View, Sales_Screen_ViewModel>
    implements Sales_Navigator {
  final TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: "1");
  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  int InvoiceNo = 100001;

  double totalDoub = 0.0;
  var formKey = GlobalKey<FormState>();
  late int selectedRow;

  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(
            "Rodina kids",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultElevatedButton(
                      widgets: const [
                        Icon(Icons.arrow_back_ios),
                      ],
                      onPressed: () {
                        numberMinasInvoice();
                        setState(() {});
                      }),
                  const SizedBox(
                    width: 5,
                  ),
                  DefaultElevatedButton(widgets: [
                    Text('Invoice No $InvoiceNo'),
                  ], onPressed: () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  DefaultElevatedButton(
                      widgets: [
                        Icon(Icons.arrow_forward_ios),
                      ],
                      onPressed: () {
                        numberPlusInvoice();
                        setState(() {});
                      }),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    TextFormField(
                      onTap: () {
                        productController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: productController.text.length);
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty || value.trim() == '') {
                          return "Enter Product";
                        }
                      },
                      controller: productController,
                      decoration: InputDecoration(labelText: 'Product'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              quantityController.selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: quantityController.text.length);

                              // quantityController.clear();
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty || value.trim() == '') {
                                return "Enter Quantity";
                              }
                            },
                            controller: quantityController,
                            decoration: InputDecoration(labelText: 'Quantity'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onTap: () async {
                              await scanQRCode();
                              setState(() {});
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty || value.trim() == '') {
                                return "Enter code";
                              }
                              return null;
                            },
                            controller: codeController,
                            decoration: const InputDecoration(
                              labelText: 'code',
                              suffixIcon: Icon(Icons.qr_code_2),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      onTap: () {
                        priceController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: priceController.text.length);
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty || value.trim() == '') {
                          return "Enter Price";
                        }
                      },
                      controller: priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10.0),
                  ]),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .07,
                child: DefaultElevatedButton(
                    widgets: [
                      Text(
                        "Add Invoice ",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Icon(Icons.keyboard_double_arrow_down),
                    ],
                    onPressed: () {
                      validInvoice();
                    }),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  dividerThickness: 2,
                  sortColumnIndex: 1,
                  sortAscending: true,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'No.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Product',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Quantity',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Price ',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'code',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.red),
                      ),
                    ),
                  ],
                  rows: viewModel.addInvoiceInRowInTheTable(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total: ',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 25),
                  ),
                  Text(
                    /// Multiply all values of price and quantity to get the total
                    ' ${viewModel.listInvoiceItem.fold(0.0, (sum, invoice) => (sum + invoice.quantity * invoice.price).toDouble())} ',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Sales_Screen_ViewModel initViewModel() {
    return Sales_Screen_ViewModel();
  }

  void validInvoice() {
    if (formKey.currentState!.validate()) {
      int quantityInt = int.parse(quantityController.text);
      double priceDoub = double.parse(priceController.text);
      int codeInt = int.parse(codeController.text);
      totalDoub = priceDoub * quantityInt;
      viewModel.createInvoice(
          product: productController.text,
          quantity: quantityInt,
          price: priceDoub,
          code: codeInt,
          total: totalDoub);
      setState(() {});
      productController.clear();
      quantityController.text = '1';
      priceController.clear();
      codeController.clear();
      print(viewModel.listInvoiceItem[0].code);
    }
  }

  @override
  void saveInvoice() {
    Navigator.pushNamed(context, Invoices_View.routeName,
        arguments: viewModel.listInvoiceItem
            .map((InvoiceItem) => InvoiceItem)
            .toList());
  }

  @override
  void editInvoiceCode({String message = "Loading..."}) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            color: RODINACOLOR,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      message,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    labelText: message,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void editInvoicePrice({String message = "Loading..."}) {
    //
  }

  @override
  void editInvoiceProduct(String title, String value) {
    showDialog(
      context: context,
      builder: (context) {
        return TextDialogWidget(value: value, title: title);
      },
    );
    setState(() {
      productController.text = value;
    });
  }

  @override
  void editInvoiceQuantity() {
    // TODO: implement editInvoiceQuantity
  }

  Future scanQRCode() async {
    if (!Platform.isWindows) {
      try {
        final qrCode = await FlutterBarcodeScanner.scanBarcode(
            '#ff6966', 'Cancel', true, ScanMode.QR);

        if (!mounted) return;
        if (qrCode == "-1") {
          codeController.text = '';
        } else {
          setState(() {
            codeController.text = qrCode;
            for (int i = 0; i < jsonp.length; i++) {
              if (jsonp[i][0] == int.parse(codeController.text)) {
                productController.text = jsonp[i][1];
                priceController.text = jsonp[i][2].toString();
                validInvoice();
                productController.clear();
                quantityController.text = '1';
                priceController.clear();
                codeController.clear();
                return;
              }
            }
          });
          print("QRCode_Result:--");
          print(qrCode);
        }
      } on PlatformException {
        codeController.text = '';
      }
    } else {
      try {
        setState(() {
          for (int i = 0; i < jsonp.length; i++) {
            if (jsonp[i][0] == int.parse(codeController.text)) {
              productController.text = jsonp[i][1];
              priceController.text = jsonp[i][2].toString();
              validInvoice();
              productController.clear();
              quantityController.text = '1';
              priceController.clear();
              codeController.clear();
              return;
            }
          }
        });
        print("QRCode_Result:--");
      } on PlatformException {
        codeController.text = '';
      }
    }
  }

  @override
  void numberMinasInvoice() {
    if (InvoiceNo > 100001) {
      InvoiceNo--;
    }
  }

  @override
  void numberPlusInvoice() {
    InvoiceNo++;
  }
}
