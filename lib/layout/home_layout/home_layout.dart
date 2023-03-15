import 'package:flutter/material.dart';
import 'package:sales/layout/home_layout/categoryScreen.dart';
import 'package:sales/ui/sales/createFatoura/create_fatoura_view.dart';

import '../../models/category.dart';


class HomeLayout extends StatefulWidget {

  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: AppBar(),
      body:CategoryScreen(),
    );

  }




}
