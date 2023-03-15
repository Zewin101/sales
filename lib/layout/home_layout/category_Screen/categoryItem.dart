
import 'package:flutter/material.dart';

import '../../../models/category.dart';



class CatagoryItem extends StatelessWidget {
  CategoryData categoryData;
  int index;

  CatagoryItem(this.categoryData, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: categoryData.color,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: index.isEven ? Radius.circular(25) : Radius.zero,
            topLeft: Radius.circular(25),
            bottomRight: index.isOdd ? Radius.circular(25) : Radius.zero),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Image.asset(
            categoryData.image,
            height: 80,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            categoryData.title,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
