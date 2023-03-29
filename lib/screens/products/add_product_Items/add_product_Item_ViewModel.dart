import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sales/base.dart';
import 'package:sales/shared/network/remote/firebase_Utils.dart';
import '../models_products/category_products.dart';
import '../models_products/prodacts_model.dart';

class Products_Item_ViewModel extends BaseViewModel<Products_Item_Naivagator> {
  // List<Products_Model> products = [];
  File? image;
  var imageUrl;

  /// get image Path

  Future getImagePath() async {
    navigator!.showLoading(message: 'loading...');
    var imagePath = basename(image!.path);
    print('path image ---------->>>>>>>>>>${imagePath}');

    /// Upload Image
    int random = Random().nextInt(1000000);
    imagePath = 'zewin$random';
    var refStorage =
        FirebaseStorage.instance.ref('images Zewin').child('$imagePath');
   navigator!.hideLoading();
    await refStorage.putFile(image!);
    imageUrl = await refStorage.getDownloadURL();
    print(imageUrl);
  }

  // List<String> categoryProductsItems = [
  //   'No category',
  // ];
  var addCategoryController = TextEditingController();
  var nameController = TextEditingController();
  var codeController = TextEditingController();
  var priceSellController = TextEditingController();
  var quantityController = TextEditingController();
  var totalController = TextEditingController();
  var categoryController = TextEditingController();
  var priceBuyController = TextEditingController();

  // void addCategoryInList() {
  //   categoryProductsItems.add(addCategoryController.text);
  // }

  /// add category
  addCategoryInFirestore({required String categoryName}) async {
    CategoryProducts category = CategoryProducts(nameCategory: categoryName);
    await FirebaseUtils.addCategoryInFireStore(category).then((value) {});
  }

  /// Read all Category

  readAllCategory() async {
    await FirebaseUtils.readAllCategoryFromFirebaseFirestore();
    // print(object)
  }

  /// Add Product
  addProductInFirestore(
      {required String productName,
      required String code,
      required String category,
      required String sellingPrice,
      required String priceBuy,
      required String quantity}) async {
    Products_Model product = Products_Model(
        productName: productName,
        code: code,
        category: category,
        sellingPrice: sellingPrice,
        priceBuy: priceBuy,
        quantity: quantity,
        productImage: imageUrl);
    navigator!.showLoading();

    await FirebaseUtils.addProductInCategoryInFireStore(product);
    navigator!.showMessage('Product Added');
    navigator!.hideLoading();
    navigator!.hideLoading();
    print(product);
    addCategoryController.clear();
    nameController.clear();
    codeController.clear();
    priceSellController.clear();
    quantityController.clear();
    totalController.clear();
    categoryController.clear();
    priceBuyController.clear();
  }
}

abstract class Products_Item_Naivagator extends BaseNavigator {
  void ShowBottomSheet();
}
