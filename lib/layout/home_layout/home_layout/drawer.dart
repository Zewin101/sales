import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales/shared/componant/componants.dart';
import 'package:sales/styles/colors.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<DrawerScreen> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .60,
      color: RODINACOLOR,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .17,
            child: Center(
              child: Text(
                '\n\n\nبرنامج رودينا كيدز \nللحسابات',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
          ),
          DefaultElevatedButton(widgets: [Text('')], onPressed: (){})

        ],
      ),
    );
  }
}
