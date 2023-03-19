

import 'package:flutter/material.dart';
import 'package:sales/base.dart';

class Products_Item_ViewModel extends BaseViewModel<Products_Item_Naivagator>{
  List<String>categoryProductsItems=['No category',];
  var addCategory=TextEditingController();
  var nameController = TextEditingController();
  var codeController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var totalController = TextEditingController();
  var categoryController = TextEditingController();

void addCategoryInList(){
  categoryProductsItems
      .add(addCategory.text);

}


}

abstract class Products_Item_Naivagator extends BaseNavigator{
  Future scanQRCode();
  void ShowBottomSheet();
}