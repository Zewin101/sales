import 'package:flutter/material.dart';
import 'package:sales/generated/assets.dart';

class CategoryData {

  String title;
  String image;
  Color color;

  CategoryData( this.title, this.image, this.color);

  static List<CategoryData> getCategoryData() {
    return [
      CategoryData( 'العملاء', Assets.imageCustomer, Color(0xFFC99852)),
      CategoryData( 'المبيعات', Assets.imagePurchase, Color(0xFFCF7E48)),
      CategoryData( 'التقارير', Assets.imageRating, Color(0xFF003E90)),
      CategoryData( 'المخزون', Assets.imageStore, Color(0xFFED1E79)),
      CategoryData( 'المشتريات', Assets.imagePurchasing, Color(0xFFED1E79)),
    ];
  }
}
