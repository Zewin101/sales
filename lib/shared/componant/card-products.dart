import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class Items_Products extends StatelessWidget {
  String productName;
  String code;
  String priceBuy;
  String priceSelling;
  String quantity;
  String image;
  String category;
  int index;
  Function addProduct;
  Function subProduct;
  int counte;

  Items_Products({
    required this.productName,
    required this.code,
    required this.priceBuy,
    required this.priceSelling,
    required this.quantity,
    required this.image,
    required this.category,
    required this.index,
    required this.addProduct,
    required this.subProduct,
    required this.counte,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(

          color: Colors.white70,
          elevation: 20,
          shadowColor: RODINACOLOR,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * .15,
                height: MediaQuery.of(context).size.width * .15,
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
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2),
                    Text(priceSelling,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: Colors.blue)),
                    // Text(
                    //   priceBuy,
                    //   style: Theme.of(context).textTheme.subtitle2,
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                   subProduct();
                  },
                  child: Icon(
                    Icons.remove_circle_outlined,
                    size: 30,
                    color: RODINACOLOR,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "$counte",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 25,color: Colors.redAccent),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    addProduct();
                  },
                  child: Icon(
                    Icons.add_circle_outlined,
                    size: 30,
                    color: RODINACOLOR,
                  ),
                ),

              ),
              SizedBox(width: 5,)
            ],
          ),
        ),
      ],
    );
  }
}
