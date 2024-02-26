import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dolistify/widget/scheduled_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScheduledPage extends StatefulWidget {
  const ScheduledPage({Key? key}) : super(key: key);

  @override
  State<ScheduledPage> createState() => ScheduledPageState();
}

class ScheduledPageState extends State<ScheduledPage> {
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: TextEditingController(),
          onSave: () => Navigator.of(context).pop(),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // DateTime _selectedDate = DateTime.now();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Scheduled Task',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 196, 124),
                      ),
                    ),
                  ),
                  Text(
                    'Today :',
                    style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: createNewTask,
                child: Container(
                  height: 70,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 2, 196, 124),
                  ),
                  child: Center(
                    child: Text(
                      '+ Add',
                      style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color.fromARGB(255, 2, 196, 124),
              onDateChange: (selectedDate) => {
                setState(() {
                  // _selectedDate = selectedDate;
                }),
              },
            ),
          )
        ],
      ),
    );
  }
}
