

import 'package:sales/base.dart';

class Products_Item_ViewModel extends BaseViewModel<Products_Item_Naivagator>{


}

abstract class Products_Item_Naivagator extends BaseNavigator{
  Future scanQRCode();
}