// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// class DashboardAnalitycs extends StatefulWidget {
//   DashboardAnalitycs({super.key});

//   @override
//   State<DashboardAnalitycs> createState() => _DashboardAnalitycsState();
// }

// class _DashboardAnalitycsState extends State<DashboardAnalitycs> {
//   List<_SalesData> data = [
//     _SalesData('Jan', 35),
//     _SalesData('Feb', 28),
//     _SalesData('Mar', 34),
//     _SalesData('Apr', 32),
//     _SalesData('May', 40)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter chart'),
//       ),
//       body: Column(
//         children: [
//           SfCartesianChart(
//             primaryXAxis: CategoryAxis(),
//             title: ChartTitle(text: 'Half yearly sales analysis'),
//             legend: Legend(isVisible: true),
//             tooltipBehavior: TooltipBehavior(enable: true),
//             series: <ChartSeries<_SalesData, String>>[
//               LineSeries<_SalesData, String>(
//                 dataSource: data,
//                 xValueMapper: (_SalesData sales, _) => sales.year,
//                 yValueMapper: (_SalesData sales, _) => sales.sales,
//                 name: 'Sales',
//                 dataLabelSettings: DataLabelSettings(isVisible: true),
//               ),
//             ],
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SfSparkLineChart.custom(
//                 trackball: SparkChartTrackball(
//                   activationMode: SparkChartActivationMode.tap,
//                 ),
//                 marker: SparkChartMarker(
//                   displayMode: SparkChartMarkerDisplayMode.all,
//                 ),
//                 labelDisplayMode: SparkChartLabelDisplayMode.all,
//                 xValueMapper: (int index) => data[index].year,
//                 yValueMapper: (int index) => data[index].sales,
//                 dataCount: 5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }
