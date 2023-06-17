import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';
import 'package:mysavingapp/config/repository/dashboard_repository.dart';
import 'package:mysavingapp/pages/dashboard/conf/cubit/dashboard_analitycs_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config/models/dashboard_model.dart';

class DashboardAnalitycsPage extends StatelessWidget {
  const DashboardAnalitycsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardAnalitycsCubit(dashboardRepository: DashboardRepository())
            ..getSummary(),
      child: analitycsBloc(),
    );
  }

  Widget analitycsBloc() {
    return BlocConsumer<DashboardAnalitycsCubit, DashboardAnalitycsState>(
      listener: (context, state) {
        if (state is DashboardAnalitycsSuccess) {
          // Dodaj kod obsługi sukcesu, jeśli jest potrzebny
        }
      },
      builder: (context, state) {
        if (state is DashboardAnalitycsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is DashboardAnalitycsError) {
          return const Center(child: Text('Coś poszło nie tak'));
        }
        if (state is DashboardAnalitycsSuccess) {
          List<DashboardAnalytics> dashboardExpenses = state.dashboardExpenses;

          if (dashboardExpenses.isNotEmpty) {
            List<DashboardAnalitycsDay> last7DaysExpenses = dashboardExpenses
                .expand((analytics) => analytics.summary)
                .take(7)
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Moja analiza'),
                      ),
                      Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF444FFF),
                        ),
                        child: Center(
                          child: Text(
                            'Ten tydzień',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomPaint(
                    painter: VerticalBarChartPainter(last7DaysExpenses),
                  ),
                ),
              ],
            );
          } else {
            return Text('Brak dostępnych danych analitycznych.');
          }
        }
        return Container();
      },
    );
  }
}

class VerticalBarChartPainter extends CustomPainter {
  final List<DashboardAnalitycsDay> data;

  VerticalBarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = 10.0;
    final barSpacing = 40.0;
    final maxExpenses =
        data.map((day) => day.expenses).reduce((a, b) => a > b ? a : b);
    final chartHeight = size.height;
    final chartWidth = (barWidth + barSpacing) * data.length - barSpacing;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final dashHeight = 4.0;
    final dashSpacing = 10.0;

    // Rysowanie przecinających linii
    for (var i = 0; i < data.length; i++) {
      final x = i * (barWidth + barSpacing) + (size.width - chartWidth) / 2;

      double startY = chartHeight -
          (data[i].expenses / maxExpenses) * chartHeight / 1.5 -
          5;
      double endY = startY -
          (chartHeight - (data[i].expenses / maxExpenses) * chartHeight / 1.5) +
          10;

      // Rysowanie linii granic wydatków
      paint.color = Colors.grey; // Kolor linii granic wydatków
      paint.strokeWidth = 1.0;
      canvas.drawLine(
        Offset(x, chartHeight / 2.8),
        Offset(x + barWidth, chartHeight / 2.8),
        paint,
      );
      canvas.drawLine(
        Offset(x, chartHeight / 2),
        Offset(x + barWidth, chartHeight / 2),
        paint,
      );
      canvas.drawLine(
        Offset(x, chartHeight / 1.5),
        Offset(x + barWidth, chartHeight / 1.5),
        paint,
      );
      canvas.drawLine(
        Offset(x, chartHeight / 1.2),
        Offset(x + barWidth, chartHeight / 1.2),
        paint,
      );

      canvas.drawLine(
        Offset(x, chartHeight / 1),
        Offset(x + barWidth, chartHeight / 1),
        paint,
      );
    }

    // Rysowanie słupków
    for (var i = 0; i < data.length; i++) {
      final x = i * (barWidth + barSpacing) + (size.width - chartWidth) / 2;
      final y =
          chartHeight - (data[i].expenses / maxExpenses) * chartHeight / 1.5;

      if (data[i].date == getCurrentDate()) {
        paint.color = Colors.green;
      } else {
        paint.color = MySavingColors.defaultBlueButton;
      }

      final radius = Radius.circular(5);

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(x, y, barWidth, chartHeight - y),
          topLeft: i == 0 ? radius : Radius.zero,
          topRight: i == data.length - 1 ? radius : Radius.zero,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint,
      );

      final textStyle = TextStyle(
        color: MySavingColors.defaultBlueButton,
        fontSize: 12,
      );
      final textSpan = TextSpan(
        text: formatDate(data[i].date),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + (barWidth - textPainter.width) / 2, chartHeight + 5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  String formatDate(DateTime date) {
    final month = date.month;
    final day = date.day;
    final monthAbbreviation = getMonthAbbreviation(month);
    return '$monthAbbreviation $day';
  }

  String getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}

String getCurrentDate() {
  final now = DateTime.now();
  final day = now.day.toString().padLeft(2, '0');
  final month = now.month.toString().padLeft(2, '0');
  return '$day.$month';
}
