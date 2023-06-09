import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/sales/sales_models/InvoiceItem.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sales/styles/colors.dart';

class Sales_Screen_ViewModel extends BaseViewModel<Sales_Navigator> {
  late List<InvoiceItem> listInvoiceItem = [];
  var data;
  int rowCount = 0;
  late int selectedRow;

  void createInvoice(
      {required String product,
      required int quantity,
      required double price,
      required int code,
      required double total}) async {
    listInvoiceItem.add(InvoiceItem(
        id: ++rowCount,
        product: product,
        quantity: quantity,
        price: price,
        code: code,
        total: total));

    ///add to firebase
    addInvoiceInRowInTheTable();
  }

  List<DataRow> addInvoiceInRowInTheTable() {
    data = listInvoiceItem
        .map(
          (item) => DataRow(
            cells: [
              DataCell(
                Text(
                  item.id.toString(),
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                onLongPress: () {
                  navigator!.editInvoiceProduct('id', item.id.toString());
                  print('id==========${item.id}');
                },
              ),
              DataCell(
                  Text(
                    item.product,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ), onTap: () {
                navigator!.editInvoiceProduct('product', item.product);
                item.item(product: item.product);
              }),
              DataCell(
                  Text(item.quantity.toString(),
                      style: const TextStyle(
                          color: RODINACOLOR,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)), onTap: () {
                navigator!.editInvoiceQuantity();
              }),
              DataCell(
                  Text(item.price.toString(),
                      style: const TextStyle(
                          color: RODINACOLOR,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)), onTap: () {
                navigator!.editInvoiceQuantity();
              }),
              DataCell(Text(item.code.toString(),style: const TextStyle(
                  color: RODINACOLOR,
                  fontSize: 20,
                  fontWeight: FontWeight.w800
              )), onTap: () {
                navigator!.editInvoiceCode();
              }),
              DataCell(Text(
                item.total.toString(),
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
              )),
            ],
          ),
        )
        .toList();
    return data;
  }
}

abstract class Sales_Navigator extends BaseNavigator {
  void saveInvoice();

  void editInvoiceProduct(String title, String value);

  void editInvoicePrice();

  void editInvoiceQuantity();

  void editInvoiceCode();

  void numberPlusInvoice();

  void numberMinasInvoice();

// void removeRowInTable();

}
