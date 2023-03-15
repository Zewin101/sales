import 'package:flutter/material.dart';
import 'category_Screen/categoryScreen.dart';


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
