import 'package:flutter/material.dart';
import 'package:sales/generated/assets.dart';
import 'package:sales/styles/colors.dart';

class CategoryData {

  String title;
  String image;
  Color color;

  CategoryData( this.title, this.image, this.color);

  static List<CategoryData> getCategoryData() {
    return [
      CategoryData( 'العملاء', Assets.imageCustomer, CATCOLOR),
      CategoryData( 'المبيعات', Assets.imagePurchase, CATCOLOR2),
      CategoryData( 'التقارير', Assets.imageRating, CATCOLOR3),
      CategoryData( 'المخزون', Assets.imageStore, CATCOLOR4),
      CategoryData( 'المشتريات', Assets.imagePurchasing,CATCOLOR5),
      CategoryData( 'المنتجات', Assets.imageProducts,CATCOLOR6),
    ];
  }
}
