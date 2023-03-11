import 'package:flutter/material.dart';
import 'package:sales/base.dart';
import 'package:sales/styles/colors.dart';
import 'package:sales/ui/sales/sales_screen_Naviagator.dart';
import 'package:sales/ui/sales/sales_screen_ViewModel.dart';

import '../../models/InvoiceItem.dart';

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
  var formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Column(children: <Widget>[
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
                            },
                            controller: codeController,
                            decoration: InputDecoration(labelText: 'code'),
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
            ]),
          ),
        ));
  }

  @override
  Sales_Screen_ViewModel initViewModel() {
    return Sales_Screen_ViewModel();
  }

  void validInvoice() {
    if (formKey.currentState!.validate()) {
      viewModel.addInvoice(
          productController.text,
          int.parse(quantityController.text),
          double.parse(priceController.text),
          int.parse(codeController.text));
      productController.clear();
      quantityController.clear();
      priceController.clear();
      codeController.clear();
    }
  }
}
