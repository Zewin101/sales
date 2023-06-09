import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sales/screens/Purchases/purchases_view.dart';
import 'package:sales/screens/Treasury/treasury_view.dart';
import 'package:sales/screens/login/loginScreen/login_view.dart';
import 'package:sales/screens/setting/addUser/addUserScreen/addUser_view.dart';
import 'package:sales/screens/stock/stock_screen_view.dart';
import 'package:sales/screens/suppliers/suppliers_screen_view.dart';
import '../layout_model/category.dart';
import '../../screens/customer/customer_View.dart';
import '../../screens/products/products_View.dart';
import '../../screens/reports/reports_View.dart';
import '../../screens/sales/createFatoura/create_fatoura_view.dart';
import 'categoryItem.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var categorys = CategoryData.getCategoryData();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: categorys.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Platform.isWindows ? 5 : 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, screens[index]);
                    },
                    child: CatagoryItem(categorys[index], index));
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<String> screens = [
  ///العملاء  1
  Customer_View.routeName,

  /// المبيعات   2
  Sales_Screen_View.routeName,

  /// التقارير   3
  Reports_View.routeName,

  /// المخزون   4
  Stock_screen_view.routeName,

  /// المشتريات   5
  Purchases_View.routeName,

  /// الاصناف   6
  Products_View.routeName,

  /// الموردين   7
  suppliers_screen_view.routeName,

  /// الخزنة   8
  treasury_screen_view.routeName,

  /// الاعدادات   9
  AddUser.routeName
];
