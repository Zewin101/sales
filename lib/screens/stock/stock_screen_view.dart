import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/stock/stock_screen_viewModel.dart';


class Stock_screen_view extends StatefulWidget {

static const String routeName="Stock";
  @override
  State<Stock_screen_view> createState() => _Stock_screen_viewState();
}

class _Stock_screen_viewState
    extends BaseView<Stock_screen_view, StockScreen_viewModel>
    implements StockScreen_navigator {
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
  StockScreen_viewModel initViewModel() {
    return StockScreen_viewModel();
  }
}
