import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/generated/assets.dart';
import 'package:sales/provider/my_provider.dart';
import 'package:sales/screens/login/loginScreen/login_view.dart';
import 'categoryScreen.dart';
import 'drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.imageBack,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Rodina Kids',
              style: Theme.of(context).textTheme.headline1,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    logoutUser();
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          drawer: DrawerScreen(),
          body: Column(
            children: [
              Expanded(child: CategoryScreen()),
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'المبيعات ',textStyle: Theme.of(context).textTheme.subtitle2),
                    // Enable legend
                    legend: Legend(isVisible: false),
                    isTransposed: false,
                    selectionGesture: ActivationMode.singleTap,
                    selectionType: SelectionType.cluster,
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                          dataSource: data,
                          xValueMapper: (_SalesData sales, _) => sales.year,
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: 'Sales',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true)),
                      LineSeries<_SalesData, String>(
                          dataSource: dataa,
                          xValueMapper: (_SalesData sales, _) => sales.year,
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: 'buy',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true)),
                    ]),
              ),

            ],
          ),
        ),
      ],
    );
  }



  void logoutUser() {
    var provider = Provider.of<MyProvider>(context, listen: false);
    AwesomeDialog(
      context: context,
      title: 'LogOut',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, Login_View.routeName);
      },
    ).show();
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
List<_SalesData> data = [
  _SalesData('يناير', 35),
  _SalesData('فبراير', 28),
  _SalesData('مارس', 34),
  _SalesData('ابريل', 32),
  _SalesData('مايو', 82)
];
List<_SalesData> dataa = [
  _SalesData('يناير', 14),
  _SalesData('فبراير', 52),
  _SalesData('مارس', 54),
  _SalesData('ابريل', 0),
  _SalesData('مايو', 13)
];