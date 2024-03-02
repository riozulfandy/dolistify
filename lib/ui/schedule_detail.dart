import 'package:dolistify/data/scheduled_model.dart';
import 'package:dolistify/ui/edit_scheduled.dart';
import 'package:dolistify/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScheduleDetail extends StatefulWidget {
  final ScheduledItem mySchedule;
  const ScheduleDetail({Key? key, required this.mySchedule}) : super(key: key);

  @override
  State<ScheduleDetail> createState() => ScheduleDetailState();
}

class ScheduleDetailState extends State<ScheduleDetail> {
  ScheduledItem? _mySchedule;

  @override
  initState() {
    super.initState();
    _mySchedule = widget.mySchedule;
  }

  void editTask() async {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: EditScheduled(
              scheduledItem: _mySchedule,
            ),
          );
        },
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _mySchedule = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 2, 196, 124),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      _mySchedule!.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _mySchedule!.description,
                      style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Icon(
                      size: 30,
                      switch (_mySchedule!.category) {
                        "Work" => Icons.work,
                        "Study" => Icons.book,
                        "Life" => Icons.favorite,
                        "Personal" => Icons.person,
                        "Other" => Icons.more_horiz,
                        String() => null,
                      },
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat.yMMMMd().format(_mySchedule!.date),
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat.jm().format(_mySchedule!.timeStarted),
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.alarm,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _mySchedule!.timeReminded != null
                              ? DateFormat.jm()
                                  .format(_mySchedule!.timeReminded!)
                              : "Not reminded",
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          _mySchedule!.isDone ? Icons.done : Icons.close,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _mySchedule!.isDone ? "Done" : "Not done",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: _mySchedule!.isDone
                                    ? const Color.fromRGBO(55, 122, 59, 1)
                                    : Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (!_mySchedule!.isDone) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              editTask();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
