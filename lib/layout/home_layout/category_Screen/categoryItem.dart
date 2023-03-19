import 'package:flutter/material.dart';

import '../../layout_model/category.dart';

class CatagoryItem extends StatelessWidget {
  CategoryData categoryData;
  int index;

  CatagoryItem(this.categoryData, this.index);

  @override
  Widget build(BuildContext context) {
    Radius itemsRadiusLeft = index.isEven ? Radius.circular(25) : Radius.zero;
    Radius itemsRadiusRight = index.isOdd ? Radius.circular(25) : Radius.zero;
    return Container(
      decoration: BoxDecoration(
        color: categoryData.color,
        borderRadius: BorderRadius.only(
            topRight: const Radius.circular(25),
            bottomLeft: index != 1 && index != 4 && index != 7 && index != 10
                ? Radius.circular(25)
                : const Radius.circular(25),
            topLeft: const Radius.circular(25),
            bottomRight: index != 1 && index != 4 && index != 7 && index != 10
                ? Radius.circular(25)
                : Radius.circular(25)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Image.asset(
              categoryData.image,
              height: 30,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            categoryData.title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 3,)
        ],
      ),
    );
  }
}
