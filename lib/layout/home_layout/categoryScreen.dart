import 'package:flutter/material.dart';

import '../../models/category.dart';
import '../../ui/sales/createFatoura/create_fatoura_view.dart';
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
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                       Navigator.pushNamed(context, Screens[index]);
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
List Screens=[
  Sales_Screen_View.routeName,
  Sales_Screen_View.routeName,
  Sales_Screen_View.routeName,
  Sales_Screen_View.routeName,
  Sales_Screen_View.routeName,
];