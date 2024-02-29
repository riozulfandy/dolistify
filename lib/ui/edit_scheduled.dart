// ignore_for_file: no_leading_underscores_for_local_identifiers, duplicate_ignore

import 'package:dolistify/widget/appbar.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditScheduled extends StatefulWidget {
  final String title;
  const EditScheduled(this.title, {Key? key}) : super(key: key);
  @override
  EditScheduledState createState() => EditScheduledState();
}

class EditScheduledState extends State<EditScheduled> {
  final _formKey = GlobalKey<FormState>();

  @override
  // ignore: duplicate_ignore, duplicate_ignore
  Widget build(BuildContext context) {
    String _title = '';
    // ignore: no_leading_underscores_for_local_identifiers
    String _description = '';
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    DateTime _date = DateTime.now();
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    TimeOfDay _timestart = TimeOfDay.now();
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    TimeOfDay _timeend = TimeOfDay.now();
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    String _cat = '';
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    String _remind = '';
    // ignore: no_leading_underscores_for_local_identifiers
    final List<String> _catList = [
      "Work",
      "Study",
      "Life",
      "Personal",
      "Other",
    ];
    // ignore: no_leading_underscores_for_local_identifiers
    final List<String> _reminder = [
      "None",
      "5 minutes before",
      "15 minutes before",
      "30 minutes before",
    ];
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _dateController = TextEditingController(
      text: DateFormat.yMMMMd().format(DateTime.now()),
    );
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _timeStartController = TextEditingController(
      text: TimeOfDay.now().format(context),
    );
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _timeEndController = TextEditingController();
    Future<void> selectDate() async {
      DateTime? datepicked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)));
      if (datepicked != null) {
        setState(() {
          _date = datepicked;
        });
        _dateController.text = DateFormat.yMMMMd().format(datepicked);
      }
    }

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
                  widget.title,
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
                  initialValue: _description,
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
                  initialValue: _title,
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
                  initialSelection:
                      widget.title == "Edit Task" ? null : _catList.first,
                  onSelected: (String? value) {
                    setState(() {
                      _cat = value!;
                    });
                  },
                  dropdownMenuEntries: _catList
                      .map((e) => DropdownMenuEntry<String>(
                            value: e,
                            label: e,
                            leadingIcon: switch (e) {
                              "Work" => const Icon(Icons.work,
                                  color: Color.fromARGB(255, 2, 196, 124)),
                              "Study" => const Icon(Icons.book,
                                  color: Color.fromARGB(255, 2, 196, 124)),
                              "Life" => const Icon(Icons.favorite,
                                  color: Color.fromARGB(255, 2, 196, 124)),
                              "Personal" => const Icon(Icons.person,
                                  color: Color.fromARGB(255, 2, 196, 124)),
                              "Other" => const Icon(Icons.more_horiz,
                                  color: Color.fromARGB(255, 2, 196, 124)),
                              String() => null,
                            },
                          ))
                      .toList(),
                  requestFocusOnTap: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dateController,
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
                    selectDate();
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _timeStartController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Start time shouldn't be empty!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          labelText: "Start Time",
                          prefixIcon: Icon(Icons.access_time),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _timeEndController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "End time shouldn't be empty!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          labelText: "End Time",
                          prefixIcon: Icon(Icons.access_time),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {},
                      ),
                    )
                  ],
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
                  initialSelection: _reminder.first,
                  leadingIcon: const Icon(
                    Icons.notifications_active,
                  ),
                  onSelected: (String? value) {
                    setState(() {
                      _remind = value!.split(" ").first;
                    });
                  },
                  dropdownMenuEntries: _reminder
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Task has been saved!"),
                          ),
                        );
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
