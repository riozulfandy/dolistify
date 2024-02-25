import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduledPage extends StatefulWidget {
  const ScheduledPage({Key? key}) : super(key: key);

  @override
  State<ScheduledPage> createState() => ScheduledPageState();
}

class ScheduledPageState extends State<ScheduledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now())),
                const Text('Scheduled Page'),
              ],
            )
          ],
        )
      ],
    ));
  }
}
