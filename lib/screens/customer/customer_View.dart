import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/customer/customer_ViewModel.dart';

class Customer_View extends StatefulWidget {
  static const String routeName = 'Customer';

  @override
  State<Customer_View> createState() => _Customer_ViewState();
}

class _Customer_ViewState extends BaseView<Customer_View, Customer_ViewModel>
    implements Customer_Naviagtor {
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
        child: Scaffold(appBar: AppBar(title: Text('Customer'))));
  }

  @override
  Customer_ViewModel initViewModel() {
    return Customer_ViewModel();
  }
}
