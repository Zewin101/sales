import 'package:flutter/material.dart';
import 'package:sales/base.dart';
import 'package:sales/models/InvoiceItem.dart';
import 'package:pdf/widgets.dart' as pw;




class Sales_Screen_ViewModel extends BaseViewModel<Sales_Navigator> {
  late List<InvoiceItem> listInvoiceItem = [];
  var data;
  int rowCount = 0;


  void createInvoice(
      {required String product,
      required int quantity,
      required double price,
      required int code,
      required double total}) async {

    listInvoiceItem.add(InvoiceItem(id: ++rowCount,
        product: product, quantity: quantity, price: price, code: code,total: total));
///add to firebase
    addInvoiceInRowInTheTable();

  }

  List<DataRow> addInvoiceInRowInTheTable() {
    data = listInvoiceItem
        .map((item) => DataRow(cells: [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.product)),
              DataCell(Text(item.quantity.toString())),
              DataCell(Text(item.price.toString())),
              DataCell(Text(item.code.toString())),
              DataCell(Text(item.total.toString())),
            ],

    ),


    )
        .toList();
    return data;
  }


}


abstract class Sales_Navigator extends BaseNavigator{
void saveInvoice();
}