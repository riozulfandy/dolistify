import 'dart:math';

import 'package:dolistify/data/scheduled_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';

class _BarChart extends StatelessWidget {
  final int maxTaskOnDay;
  final List doneTaskOnDay;
  const _BarChart(this.maxTaskOnDay, this.doneTaskOnDay);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxTaskOnDay > 10 ? maxTaskOnDay.toDouble() + 2 : 12,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Sun';
        break;
      case 1:
        text = 'Mon';
        break;
      case 2:
        text = 'Tue';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'Thu';
        break;
      case 5:
        text = 'Fri';
        break;
      case 6:
        text = 'Sat';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: doneTaskOnDay[0],
              color: Colors.white,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: doneTaskOnDay[1],
              color: Colors.white,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: doneTaskOnDay[2],
              color: Colors.white,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: doneTaskOnDay[3],
              color: Colors.white,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: doneTaskOnDay[4],
              color: Colors.white,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: doneTaskOnDay[5],
              color: Colors.white,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: doneTaskOnDay[6],
              color: Colors.white,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  final ScheduledData _scheduledData = ScheduledData();
  final _box = Hive.box('myBox');
  List doneTaskOnDay = [0, 0, 0, 0, 0, 0, 0];
  int maxTaskOnDay = 0;

  @override
  void initState() {
    super.initState();
    if (_box.get('scheduledOnDate') == null) {
      _scheduledData.initialData();
      _scheduledData.updateData();
    } else {
      _scheduledData.loadData();
    }
    updateData();
  }

  DateTime getSunday() {
    final DateTime sunday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    while (sunday.weekday != DateTime.sunday) {
      sunday.add(const Duration(days: -1));
    }
    return sunday;
  }

  int taskCount(DateTime date) {
    return _scheduledData.scheduledOnDate[date] == null
        ? 0
        : _scheduledData.scheduledOnDate[date]!.length;
  }

  int doneTaskCount(DateTime date) {
    return _scheduledData.scheduledOnDate[date] == null
        ? 0
        : _scheduledData.scheduledOnDate[date]!
            .where((element) => element.isDone)
            .length;
  }

  void updateData() {
    DateTime date = getSunday();
    int i = 0;
    doneTaskOnDay[i] = doneTaskCount(date);
    maxTaskOnDay = taskCount(date);
    while (date !=
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      i++;
      date = date.add(const Duration(days: 1));
      doneTaskOnDay[i] = doneTaskCount(date);
      maxTaskOnDay = max(maxTaskOnDay, taskCount(date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(maxTaskOnDay, doneTaskOnDay),
    );
  }
}
