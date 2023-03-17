import 'package:flutter/material.dart';
import 'package:sales/generated/assets.dart';
import 'package:sales/layout/home_layout/home_layout/drawer.dart';
import '../category_Screen/categoryScreen.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Assets.imageBack,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Rodina Kids',style: Theme.of(context).textTheme.headline1,),
          ),
          drawer:DrawerScreen(),
          body: CategoryScreen(),
        ),
      ],

    );
  }
}
