import 'package:flutter/material.dart';
import 'package:sales/ui/sales/createFatoura/create_fatoura_view.dart';

class HomeLayout extends StatelessWidget {
   HomeLayout({Key? key}) : super(key: key);
  static const String routeName = "HomeLayout";
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.accessibility),label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.accessibility),label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.accessibility),label: ''),
      //   ],
      // ),
      body:Sales_Screen_View() ,
    );

  }
}
