import 'package:flutter/cupertino.dart';
import 'package:sales/base.dart';

class Purchases_ViewModel extends BaseViewModel<Purchases_Naviagtor>{

  var  searchProductsController = TextEditingController();

int counter=0;

void addCounterProductItems(){
  counter++;
  notifyListeners();
}
void minasCounterProductItems(){
  counter--;
  notifyListeners();
}



}
abstract class Purchases_Naviagtor extends BaseNavigator{
  Future itemAdd();
}