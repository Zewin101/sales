import 'package:flutter/material.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/customer/customer_ViewModel.dart';
import 'package:sales/screens/reports/reports_ViewModel.dart';

import '../../shared/componant/componants.dart';

class Reports_View extends StatefulWidget {
  static const String routeName = 'Reports';

  @override
  State<Reports_View> createState() => _Customer_ViewState();
}

class _Customer_ViewState extends BaseView<Reports_View, Reports_ViewModel>
    implements Reports_Naviagtor {
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
    return Scaffold(
      appBar: AppBar(title: Text('Reports')),
      body:Column(
        children: [

        ],
      )
    );
  }

  @override
  Reports_ViewModel initViewModel() {
    return Reports_ViewModel();
  }


}
