import 'dart:io';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sales/screens/sales/createFatoura/create_fatoura_view.dart';
import 'package:sales/screens/sales/invoices/invoices_View.dart';
import 'package:sales/screens/splash/splash_screen.dart';
import 'package:sales/styles/myTheme.dart';
import 'firebase_options.dart';
import 'layout/home_layout/home_layout/home_layout.dart';

 void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid||Platform.isIOS? await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ):Container();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        Splash_Screen.routeName: (context) => Splash_Screen(),
        Sales_Screen_View.routeName: (context) => Sales_Screen_View(),
        Invoices_View.routeName: (context) => Invoices_View(),


      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
