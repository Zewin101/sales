

import 'package:sales/base.dart';

import '../../shared/network/remote/firebase_Utils.dart';

class Products_ViewModel extends BaseViewModel<Products_Naivagator>{

   DeleteProducte(String id)async{
   return await FirebaseUtils.deleteProductFromFirestore(id);
  }
   EditProducte(String id)async{

  }

}

abstract class Products_Naivagator extends BaseNavigator{
  Future scanQRCode();
}