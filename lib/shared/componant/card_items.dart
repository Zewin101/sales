import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales/generated/assets.dart';

import '../../styles/colors.dart';

class Card_Items extends StatelessWidget {
  String productName;
  String code;
  String priceBuy;
  String priceSelling;
  String quantity;
  String image;
  String category;
  int index;

  Card_Items(
      {required this.productName,
      required this.code,
      required this.priceBuy,
      required this.priceSelling,
      required this.quantity,
      required this.image,
      required this.category,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(color: Colors.grey, height: 2, width: double.infinity),
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.width * .2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(8),
                  color: RODINACOLOR),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName,
                      style: Theme.of(context).textTheme.subtitle2),
                  Text(priceSelling,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: Colors.redAccent)),
                  Text(
                    priceBuy,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            Container(
                color: Colors.grey,
                height: MediaQuery.of(context).size.width * .2,
                width: 2),
            Expanded(
                child: Text(
              quantity,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.deepPurpleAccent,fontSize: 30),
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ],
    );
  }
}
