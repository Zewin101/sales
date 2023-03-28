
import 'package:flutter/material.dart';

import '../../styles/colors.dart';

Future Product_Details(
    {required String productName,
       String? productImage,
      required String code,
      required String category,
       String? quantity,
    required BuildContext context
    }) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          productName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(1),
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.width * .95,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        productImage!,
                      ),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(8),
                  color: RODINACOLOR),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              'Code :$code',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              'category:  $category',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '  quantity : $quantity',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      );
    },
  );
}