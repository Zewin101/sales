import 'package:flutter/material.dart';
import 'package:sales/base.dart';
import 'package:sales/shared/componant/componants.dart';
import 'package:sales/styles/colors.dart';
import 'package:sales/ui/sales/invoices/invoices_View.dart';

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
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  double totalDoub = 0.0;
  var formKey = GlobalKey<FormState>();
  late int selectedRow;

  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveInvoice();
        },
        child: Icon(Icons.save),
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
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(children: [
                  TextFormField(
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
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
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
              child: ElevatedButton(
                  onPressed: () {
                    validInvoice();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(RODINACOLOR),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Invoice ",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Icon(Icons.keyboard_double_arrow_down),
                    ],
                  )),
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
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Product',
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Quantity',
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Price ',
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'code',
                      style: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: TextStyle(
                          fontStyle: FontStyle.normal, color: Colors.red),
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
      quantityController.clear();
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
}
