import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarChart extends StatelessWidget {
  final List<double> data;
  final int maxData;
  const MyBarChart({super.key, required this.data, required this.maxData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: maxData.toDouble() > 10 ? maxData.toDouble() : 10,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getTitles,
            ),
          ),
        ),
        barGroups: data
            .asMap()
            .entries
            .map((e) => BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: e.value,
                      color: Colors.white,
                      width: 20,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxData.toDouble() > 10 ? maxData.toDouble() : 10,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta titleMeta) {
    TextStyle style = GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
    );
    TextStyle styleCurrent = GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: Color.fromARGB(255, 124, 245, 154),
      ),
    );
    switch (value.toInt()) {
      case 0:
        return Text('SUN',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
      case 1:
        return Text('MON',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
      case 2:
        return Text('TUE',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
      case 3:
        return Text('WED',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
      case 4:
        return Text('THU',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
      case 5:
        return Text('FRI',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
      case 6:
        return Text('SAT',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
      default:
        return Text('',
            style:
                value.toInt() == DateTime.now().weekday ? styleCurrent : style);
    }
  }
}
