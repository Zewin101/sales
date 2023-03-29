import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/products/add_product_Items/add_product_Item_View.dart';
import 'package:sales/shared/componant/card_items.dart';
import 'package:sales/screens/products/productrs_ViewModel.dart';
import 'package:sales/shared/componant/componants.dart';
import 'package:sales/shared/network/remote/firebase_Utils.dart';
import 'package:sales/styles/colors.dart';

import '../../generated/assets.dart';
import '../../shared/componant/Product_Details.dart';
import 'models_products/prodacts_model.dart';

class Products_View extends StatefulWidget {
  static const String routeName = 'Products';

  @override
  State<Products_View> createState() => _Products_ViewState();
}

class _Products_ViewState extends BaseView<Products_View, Products_ViewModel>
    implements Products_Naivagator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  var searchProductsController = TextEditingController();

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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Porducts',
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, product_Item_View.routeName);
                    },
                    icon: Icon(Icons.add))
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
                            onTap: () {
                              /// select all
                              searchProductsController.selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset:
                                          searchProductsController.text.length);
                            },
                            controller: searchProductsController,
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
                                  await viewModel.navigator?.scanQRCode1( searchProductsController.text);
                                },
                                child: const Icon(
                                  Icons.qr_code_scanner,
                                  color: RODINACOLOR,
                                  size: 45,
                                ))),
                      ),
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                                Product_Details(
                                  context:context,
                                    productName: allProducts![index].productName,
                                    productImage: allProducts![index].productImage,
                                    code: allProducts![index].code,
                                    category: allProducts![index].category,
                                    quantity: allProducts![index].quantity);
                              },
                              child: Card_Items(
                                editeProduct: ()async{
                               await  viewModel.EditProducte(allProducts[index].id);

                                },
                                deleteProduct: ()async{
                                 await viewModel.DeleteProducte(allProducts[index].id);
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
          ),
        ],
      ),
    );
  }

  @override
  Products_ViewModel initViewModel() {
    return Products_ViewModel();
  }


}
