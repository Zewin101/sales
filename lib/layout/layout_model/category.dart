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
      CategoryData( 'العملاء', Assets.imageProducts, CATCOLOR1),
      CategoryData( 'المبيعات', Assets.imagePurchase, CATCOLOR2),
      CategoryData( 'التقارير', Assets.imageRating, CATCOLOR3),
      CategoryData( 'المخزون', Assets.imageStore, CATCOLOR4),
      CategoryData( 'المشتريات', Assets.imagePurchases,CATCOLOR5),
      CategoryData( 'الاصناف', Assets.imageProducts,CATCOLOR6),
      CategoryData( ' الموردين', Assets.imageProducts,CATCOLOR7),
      CategoryData( ' الخزنة', Assets.imageTreasury,CATCOLOR8),
      CategoryData( ' الاعدادات', Assets.imageProducts,CATCOLOR9),
    ];
  }
}
