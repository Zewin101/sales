

import 'package:sales/base.dart';

class Products_ViewModel extends BaseViewModel<Products_Naivagator>{


}

abstract class Products_Naivagator extends BaseNavigator{
  Future scanQRCode();
}