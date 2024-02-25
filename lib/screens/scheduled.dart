import 'package:flutter/material.dart';

class ScheduledPage extends StatefulWidget {
  const ScheduledPage({Key? key}) : super(key: key);

  @override
  State<ScheduledPage> createState() => ScheduledPageState();
}

class ScheduledPageState extends State<ScheduledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Welcome to the ScheduledPage Page!'),
      ),
    );
  }
}
