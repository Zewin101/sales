import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/styles/colors.dart';

import '../sales_models/InvoiceItem.dart';
import 'invoices_ViewModel.dart';

class Invoices_View extends StatefulWidget {
  Invoices_View({Key? key}) : super(key: key);
  static const String routeName = "Invoices";

  @override
  State<Invoices_View> createState() => _Invoices_ViewState();
}

class _Invoices_ViewState extends BaseView<Invoices_View, Invoices_ViewMode>
    implements Ivoices_Navigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var v = ModalRoute.of(context)!.settings.arguments as List<InvoiceItem>;

    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Scaffold(
          appBar: AppBar(
            title:
                Text('customers', style: Theme.of(context).textTheme.headline1),
          ),
          body: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: v.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
                      child: Card(
                        color: index.isOdd ? RODINACOLOR : RODINACOLOR2,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .10,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Text(
                                ' ${v.fold(0.0, (sum, invoice) => (sum + invoice.quantity * invoice.price).toDouble())} ',
                                style: Theme.of(context).textTheme.headline1,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  @override
  Invoices_ViewMode initViewModel() {
    return Invoices_ViewMode();
  }
}
