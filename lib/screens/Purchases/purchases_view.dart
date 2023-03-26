import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/Purchases/purchases_viewModel.dart';
import 'package:sales/screens/customer/customer_ViewModel.dart';
import 'package:sales/screens/reports/reports_ViewModel.dart';

import '../../shared/componant/componants.dart';

class Purchases_View extends StatefulWidget {
  static const String routeName = 'Purchases';

  @override
  State<Purchases_View> createState() => _Customer_ViewState();
}

class _Customer_ViewState extends BaseView<Purchases_View, Purchases_ViewModel>
    implements Purchases_Naviagtor {
  final TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: "1");
  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  int InvoiceNo = 100001;

  double totalDoub = 0.0;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(title: Text('Purchases')),
            body: Column(
              children: [],
            ));
      },
    );
  }

  @override
  Purchases_ViewModel initViewModel() {
    return Purchases_ViewModel();
  }
}
