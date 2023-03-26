import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/suppliers/suppliers_screen_viewModel.dart';

class suppliers_screen_view extends StatefulWidget {

static const String routeName="suppliers";
  @override
  State<suppliers_screen_view> createState() => _suppliers_screen_viewState();
}

class _suppliers_screen_viewState
    extends BaseView<suppliers_screen_view, suppliersScreen_viewModel>
    implements suppliersScreen_navigator {
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
  suppliersScreen_viewModel initViewModel() {
    return suppliersScreen_viewModel();
  }
}
