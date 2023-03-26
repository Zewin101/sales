import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/Treasury/treasury_viewModel.dart';
import 'package:sales/screens/suppliers/suppliers_screen_viewModel.dart';

class treasury_screen_view extends StatefulWidget {

  static const String routeName="treasury";
  @override
  State<treasury_screen_view> createState() => _suppliers_screen_viewState();
}

class _suppliers_screen_viewState
    extends BaseView<treasury_screen_view, treasury_viewModel>
    implements treasury_navigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(),
        );
      },
    );
  }

  @override
  treasury_viewModel initViewModel() {
    return treasury_viewModel();
  }


}
