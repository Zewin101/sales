import 'package:flutter/material.dart';
import 'package:sales/screens/products/products_View.dart';
import 'package:sales/screens/sales/createFatoura/create_fatoura_view.dart';
import 'package:sales/screens/setting/addUser/addUserScreen/addUser_view.dart';

import 'package:sales/styles/colors.dart';

import '../../../screens/customer/customer_View.dart';

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
          SizedBox(
            height: MediaQuery.of(context).size.height * .22,
            child: Center(
              child: Text(
                '\n\nبرنامج رودينا كيدز \nللحسابات',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Container(
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Sales_Screen_View.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المبيعات ',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Icon(Icons.scatter_plot_outlined)
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Sales_Screen_View.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المشتريات ',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Icon(Icons.shopping_basket_outlined)
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Customer_View.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'العملاء ',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Icon(Icons.person)
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Customer_View.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المخزن ',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Icon(Icons.backup_table)
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Products_View.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المنتجات ',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Icon(Icons.local_shipping_rounded)
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AddUser.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Setting ',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Icon(Icons.settings)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
