import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/generated/assets.dart';
import 'package:sales/layout/home_layout/home_layout/drawer.dart';
import 'package:sales/provider/my_provider.dart';
import 'package:sales/screens/login/loginScreen/login_view.dart';
import 'package:sales/shared/network/remote/firebase_Utils.dart';
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
        Image.asset(
          Assets.imageBack,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Rodina Kids',
              style: Theme.of(context).textTheme.headline1,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    logoutUser();
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          drawer: DrawerScreen(),
          body: CategoryScreen(),
        ),
      ],
    );
  }

  void logoutUser() {
    var provider = Provider.of<MyProvider>(context,listen: false);
    AwesomeDialog(
      context: context,
      title: 'LogOut',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
       FirebaseAuth.instance.signOut();
       Navigator.pushReplacementNamed(context, Login_View.routeName);
       },
    ).show();
  }
}
