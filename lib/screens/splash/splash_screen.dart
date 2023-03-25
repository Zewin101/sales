import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sales/generated/assets.dart';
import 'package:sales/layout/home_layout/home_layout.dart';

class Splash_Screen extends StatelessWidget {
  const Splash_Screen({Key? key}) : super(key: key);
static const String routeName='splashScreen';

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);

    });
    return Scaffold(

    );
  }
}
