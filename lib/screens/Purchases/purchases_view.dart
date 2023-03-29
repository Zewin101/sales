import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/Purchases/purchases_viewModel.dart';
import 'package:sales/screens/customer/customer_ViewModel.dart';
import 'package:sales/screens/reports/reports_ViewModel.dart';
import 'package:sales/shared/componant/Product_Details.dart';

import '../../shared/componant/card-products.dart';
import '../../shared/componant/componants.dart';
import '../../shared/network/remote/firebase_Utils.dart';
import '../../styles/colors.dart';
import '../../shared/componant/card_items.dart';
import '../products/models_products/category_products.dart';
import '../products/models_products/prodacts_model.dart';

class Purchases_View extends StatefulWidget {
  static const String routeName = 'Purchases';

  @override
  State<Purchases_View> createState() => _Customer_ViewState();
}

class _Customer_ViewState extends BaseView<Purchases_View, Purchases_ViewModel>
    implements Purchases_Naviagtor {
  final TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: "1");
  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Porducts',
              style: Theme.of(context).textTheme.headline1,
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        height: 45,
                        child: TextFormField(
                          onTap: () {
                            /// select all
                            viewModel.searchProductsController.selection =
                                TextSelection(
                                    baseOffset: 0,
                                    extentOffset: viewModel
                                        .searchProductsController.text.length);
                          },
                          controller: viewModel.searchProductsController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search',
                            border: OutlineInputBorder(
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
                                await viewModel.navigator?.scanQRCode1( viewModel.searchProductsController.text );
                              },
                              child: const Icon(
                                Icons.qr_code_scanner,
                                color: RODINACOLOR,
                                size: 45,
                              ))),
                    ),
                    SizedBox(
                      width: 7,
                    )
                  ],
                ),
                const Divider(
                  color: Colors.red,
                  thickness: 3,
                ),
                Expanded(
                  child: FutureBuilder<QuerySnapshot<Products_Model>>(
                    future: FirebaseUtils.readAllProductsFromFirestore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error ${snapshot.error}');
                      }
                      var allProducts =
                          snapshot.data?.docs.map((e) => e.data()).toList();
                      return ListView.builder(
                        itemCount: allProducts?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              viewModel.counter++;
                              print(viewModel.counter);
                            },
                            child: Items_Products(
                              deleteProduct: () async {
                                await FirebaseUtils.deleteProductFromFirestore(
                                    allProducts[index].id);
                                setState(() {

                                });
                              },
                              editeProduct: () {},
                              addProduct: () {
                                viewModel.counter++;
                                print(viewModel.counter);
                              },
                              counte: viewModel.counter,
                              subProduct: () {
                                viewModel.counter--;
                                print(viewModel.counter);
                              },
                              productName: allProducts![index].productName,
                              code: allProducts[index].code,
                              priceBuy: allProducts[index].priceBuy,
                              priceSelling: allProducts[index].sellingPrice,
                              quantity: allProducts[index].quantity,
                              image: allProducts[index].productImage,
                              category: allProducts[index].category,
                              index: index,
                            ),
                          );
                        },
                      );
                    },
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
  Purchases_ViewModel initViewModel() {
    return Purchases_ViewModel();
  }



  Future itemAdd() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 50,
          title: const Text('الكمية', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        viewModel.minasCounterProductItems();
                        print(viewModel.counter);
                      },
                      icon: Icon(Icons.remove_circle_outlined)),
                  Text(viewModel.counter.toString()),
                  IconButton(
                      onPressed: () {
                        viewModel.addCounterProductItems();
                        print(viewModel.counter);
                      },
                      icon: Icon(Icons.add_circle_outlined)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
