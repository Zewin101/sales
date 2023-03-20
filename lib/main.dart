import 'dart:io';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/provider/my_provider.dart';
import 'package:sales/screens/customer/customer_View.dart';
import 'package:sales/screens/login/loginScreen/login_view.dart';
import 'package:sales/screens/products/product_Items/product_Item_View.dart';
import 'package:sales/screens/products/products_View.dart';
import 'package:sales/screens/reports/reports_View.dart';
import 'package:sales/screens/sales/createFatoura/create_fatoura_view.dart';
import 'package:sales/screens/sales/invoices/invoices_View.dart';
import 'package:sales/screens/setting/addUser/addUserScreen/addUser_view.dart';
import 'package:sales/screens/splash/splash_screen.dart';
import 'package:sales/styles/myTheme.dart';
import 'firebase_options.dart';
import 'layout/home_layout/home_layout/home_layout.dart';

 void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid||Platform.isIOS? await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ):Container();


  runApp(
    ChangeNotifierProvider(
        create: (context) => MyProvider(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,

      initialRoute: Login_View.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        Login_View.routeName: (context) => Login_View(),
        Splash_Screen.routeName: (context) => Splash_Screen(),
        Sales_Screen_View.routeName: (context) => Sales_Screen_View(),
        Invoices_View.routeName: (context) => Invoices_View(),
        Customer_View.routeName: (context) => Customer_View(),
        Reports_View.routeName: (context) => Reports_View(),
        Products_View.routeName: (context) => Products_View(),
        product_Item_View.routeName: (context) => product_Item_View(),
        AddUser.routeName: (context) => AddUser(),


      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
