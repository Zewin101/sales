
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
String title;

Graph({required this.title});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: title,textStyle: Theme.of(context).textTheme.subtitle2),
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

        ]);
  }
}
List<_SalesData> data = [
  _SalesData('Jan', 35,25),
  _SalesData('Feb', 28,54),
  _SalesData('Mar', 34,54),
  _SalesData('Apr', 32,54),
  _SalesData('May', 40,41)
];
class _SalesData {
  _SalesData(this.year, this.sales,this.age);

  final String year;
  final double sales;
  final int age;
}