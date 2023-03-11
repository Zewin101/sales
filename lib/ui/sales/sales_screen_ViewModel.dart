
import 'package:sales/base.dart';
import 'package:sales/models/InvoiceItem.dart';
import 'package:sales/ui/sales/sales_screen_Naviagator.dart';

class Sales_Screen_ViewModel extends BaseViewModel<Sales_Navigator>{
  late List<InvoiceItem> listInvoiceItem = [];
  void addInvoice(String product,int quantity,double price,int code){
   listInvoiceItem.add( InvoiceItem(product: product, quantity: quantity, price: price, code: code));

  }
}