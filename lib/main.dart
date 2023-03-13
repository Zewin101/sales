import 'package:flutter/material.dart';
import 'package:sales/styles/myTheme.dart';
import 'package:sales/ui/sales/createFatoura/create_fatoura_view.dart';

import 'package:sales/ui/splash/splash_screen.dart';


import 'layout/home_layout/home_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      initialRoute: Sales_Screen_View.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        Splash_Screen.routeName: (context) => Splash_Screen(),
        Sales_Screen_View.routeName: (context) => Sales_Screen_View(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
