import 'dart:io';
import 'package:flutter/material.dart';
import '../../layout_model/category.dart';
import '../../../screens/customer/customer_View.dart';
import '../../../screens/products/products_View.dart';
import '../../../screens/reports/reports_View.dart';
import '../../../screens/sales/createFatoura/create_fatoura_view.dart';
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
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:Platform.isWindows?5:3,
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
List<String> screens=[
  Customer_View.routeName,
  Sales_Screen_View.routeName,
  Reports_View.routeName,
  Sales_Screen_View.routeName,
  Sales_Screen_View.routeName,
  Products_View.routeName,
];