import 'package:dolistify/data/scheduled_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScheduledTile extends StatelessWidget {
  final ScheduledItem schedule;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  const ScheduledTile({
    super.key,
    required this.schedule,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: taskCompleted
                ? const Color.fromRGBO(55, 122, 59, 1)
                : const Color.fromARGB(255, 2, 196, 124),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: const Color.fromARGB(255, 2, 196, 124),
                checkColor: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.title,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: taskCompleted ? Colors.black : Colors.white,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat.jm().format(schedule.timeStarted),
                          style: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.alarm,
                          color: Colors.black,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          schedule.timeReminded == null
                              ? "None"
                              : schedule.timeReminded!
                                          .difference(schedule.timeStarted)
                                          .inMinutes ==
                                      -5
                                  ? "5 minutes before"
                                  : schedule.timeReminded!
                                              .difference(schedule.timeStarted)
                                              .inMinutes ==
                                          -15
                                      ? "15 minutes before"
                                      : schedule.timeReminded!
                                                  .difference(
                                                      schedule.timeStarted)
                                                  .inMinutes ==
                                              -30
                                          ? "30 minutes before"
                                          : "None",
                          style: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                switch (schedule.category) {
                  "Work" => Icons.work,
                  "Study" => Icons.book,
                  "Life" => Icons.favorite,
                  "Personal" => Icons.person,
                  "Other" => Icons.more_horiz,
                  String() => null,
                },
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
