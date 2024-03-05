import 'package:dolistify/data/scheduled_data.dart';
import 'package:dolistify/data/scheduled_model.dart';
import 'package:dolistify/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditScheduled extends StatefulWidget {
  final ScheduledItem? scheduledItem;
  const EditScheduled({
    Key? key,
    this.scheduledItem,
  }) : super(key: key);
  @override
  EditScheduledState createState() => EditScheduledState();
}

class EditScheduledState extends State<EditScheduled> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";
  DateTime _date = DateTime.now();
  TimeOfDay _timestart = TimeOfDay.now();
  String _cat = "Work";
  String _remind = "None";
  final ScheduledData _scheduledData = ScheduledData();

  @override
  void initState() {
    super.initState();
    _scheduledData.loadData();
    if (widget.scheduledItem != null) {
      _title = widget.scheduledItem!.title;
      _description = widget.scheduledItem!.description;
      _date = widget.scheduledItem!.date;
      _timestart = TimeOfDay.fromDateTime(widget.scheduledItem!.timeStarted);
      _cat = widget.scheduledItem!.category;
      _remind = widget.scheduledItem!.timeReminded == null
          ? "None"
          : widget.scheduledItem!.timeReminded!
                      .difference(widget.scheduledItem!.timeStarted)
                      .inMinutes ==
                  -5
              ? "5 minutes before"
              : widget.scheduledItem!.timeReminded!
                          .difference(widget.scheduledItem!.timeStarted)
                          .inMinutes ==
                      -15
                  ? "15 minutes before"
                  : widget.scheduledItem!.timeReminded!
                              .difference(widget.scheduledItem!.timeStarted)
                              .inMinutes ==
                          -30
                      ? "30 minutes before"
                      : "None";
    }
  }

  Future<void> selectDate(dateController) async {
    DateTime? datepicked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (datepicked != null) {
      setState(() {
        _date = datepicked;
        dateController.text = DateFormat.yMMMMd().format(datepicked);
      });
    }
  }

  Future<void> displayTimePicker(BuildContext context, timeController) async {
    var time = await showTimePicker(context: context, initialTime: _timestart);

    if (time != null) {
      setState(() {
        _timestart = time;
        timeController.text = _timestart.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> catList = [
      "Work",
      "Study",
      "Life",
      "Personal",
      "Other",
    ];
    final List<String> reminder = [
      "None",
      "5 minutes before",
      "15 minutes before",
      "30 minutes before",
    ];
    TextEditingController dateController = TextEditingController(
      text: DateFormat.yMMMMd().format(_date),
    );
    TextEditingController timeStartController = TextEditingController(
      text: _timestart.format(context),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  widget.scheduledItem == null ? "Add Task" : "Edit Task",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 196, 124),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title shouldn't be empty!";
                    }
                    return null;
                  },
                  initialValue: _title,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    labelText: "Title",
                    hintText: "Enter the title",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  initialValue: _description,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    hintText: "Enter the description",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownMenu<String>(
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  label: const Text("Category"),
                  initialSelection: _cat,
                  onSelected: (String? value) {
                    setState(() {
                      _cat = value!;
                    });
                  },
                  dropdownMenuEntries: catList
                      .map((e) => DropdownMenuEntry<String>(
                            value: e,
                            label: e,
                            leadingIcon: switch (e) {
                              "Work" =>
                                const Icon(Icons.work, color: Colors.black),
                              "Study" =>
                                const Icon(Icons.book, color: Colors.black),
                              "Life" =>
                                const Icon(Icons.favorite, color: Colors.black),
                              "Personal" =>
                                const Icon(Icons.person, color: Colors.black),
                              "Other" => const Icon(Icons.more_horiz,
                                  color: Colors.black),
                              String() => null,
                            },
                          ))
                      .toList(),
                  requestFocusOnTap: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: dateController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Date shouldn't be empty!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    labelText: "Date",
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    selectDate(dateController);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: timeStartController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Time shouldn't be empty!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    labelText: "Time",
                    prefixIcon: Icon(Icons.access_time),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    displayTimePicker(context, timeStartController);
                  },
                ),
                const SizedBox(height: 10),
                DropdownMenu<String>(
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  label: const Text("Reminder"),
                  initialSelection: _remind,
                  leadingIcon: const Icon(
                    Icons.notifications_active,
                  ),
                  onSelected: (String? value) {
                    setState(() {
                      _remind = value!;
                    });
                  },
                  dropdownMenuEntries: reminder
                      .map((e) => DropdownMenuEntry<String>(
                            value: e,
                            label: e,
                          ))
                      .toList(),
                  requestFocusOnTap: false,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 2, 196, 124)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScheduledItem newSchedule = ScheduledItem(
                          title: _title,
                          description: _description,
                          date: DateTime(_date.year, _date.month, _date.day),
                          timeStarted: DateTime(
                            _date.year,
                            _date.month,
                            _date.day,
                            _timestart.hour,
                            _timestart.minute,
                          ),
                          category: _cat,
                          timeReminded: _remind == "None"
                              ? null
                              : _remind == "5 minutes before"
                                  ? DateTime(
                                      _date.year,
                                      _date.month,
                                      _date.day,
                                      _timestart.hour,
                                      _timestart.minute - 5,
                                    )
                                  : _remind == "15 minutes before"
                                      ? DateTime(
                                          _date.year,
                                          _date.month,
                                          _date.day,
                                          _timestart.hour,
                                          _timestart.minute - 15,
                                        )
                                      : _remind == "30 minutes before"
                                          ? DateTime(
                                              _date.year,
                                              _date.month,
                                              _date.day,
                                              _timestart.hour,
                                              _timestart.minute - 30,
                                            )
                                          : null,
                          isDone: false,
                        );

                        if (widget.scheduledItem != null) {
                          _scheduledData.updateScheduled(
                              widget.scheduledItem!, newSchedule);
                          _scheduledData.updateData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Task has been updated!"),
                            ),
                          );
                          Navigator.pop(context, newSchedule);
                        } else {
                          _scheduledData.addScheduled(newSchedule);
                          _scheduledData.updateData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Task has been saved!"),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
