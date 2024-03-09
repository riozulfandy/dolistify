import 'package:dolistify/data/scheduled_data.dart';
import 'package:dolistify/data/scheduled_model.dart';
import 'package:dolistify/ui/edit_scheduled.dart';
import 'package:dolistify/ui/schedule_detail.dart';
import 'package:dolistify/widget/scheduled_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dolistify/services/notification.dart';

class ScheduledPage extends StatefulWidget {
  const ScheduledPage({Key? key}) : super(key: key);

  @override
  State<ScheduledPage> createState() => ScheduledPageState();
}

class ScheduledPageState extends State<ScheduledPage> {
  @override
  void initState() {
    super.initState();
    if (_box.get('scheduledOnDate') == null) {
      scheduledData.initialData();
      scheduledData.updateData();
    } else {
      scheduledData.loadData();
    }
    _scheduledOnDate = scheduledData.scheduledOnDate[_selectedDate] ?? [];
  }

  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List _scheduledOnDate = [];
  ScheduledData scheduledData = ScheduledData();
  String _selectedCategory = "All";
  String _searchText = "";
  final _box = Hive.box('myBox');

  void createNewTask() {
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
            child: const EditScheduled(),
          );
        },
      ),
    ).then((value) {
      setState(
        () {
          scheduledData.loadData();
          _scheduledOnDate = scheduledData.scheduledOnDate[_selectedDate] ?? [];
        },
      );
    });
  }

  void taskDetail(ScheduledItem schedule) {
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
            child: ScheduleDetail(
              mySchedule: schedule,
            ),
          );
        },
      ),
    ).then((value) {
      setState(
        () {
          scheduledData.loadData();
          _scheduledOnDate = scheduledData.scheduledOnDate[_selectedDate] ?? [];
        },
      );
    });
  }

  void checkBoxChanged(bool? value, int index, DateTime date) {
    setState(() {
      ScheduledItem task = scheduledData.scheduledOnDate[date]![index];
      if (task.timeReminded != null) {
        if (task.isDone) {
          cancelNotification(int.parse(task.timeReminded!.day.toString() +
              task.timeReminded!.month.toString() +
              task.timeReminded!.year.toString() +
              task.timeReminded!.hour.toString() +
              task.timeReminded!.minute.toString()));
        } else {
          createScheduledNotification(
              int.parse(task.timeReminded!.day.toString() +
                  task.timeReminded!.month.toString() +
                  task.timeReminded!.year.toString() +
                  task.timeReminded!.hour.toString() +
                  task.timeReminded!.minute.toString()),
              task.title,
              task.description,
              task.timeReminded!);
        }
      }
      scheduledData.scheduledOnDate[date]![index].isDone =
          !scheduledData.scheduledOnDate[date]![index].isDone;
      _scheduledOnDate = scheduledData.scheduledOnDate[date] ?? [];
    });
    scheduledData.updateData();
  }

  void deleteTask(int index, DateTime date) {
    setState(() {
      ScheduledItem task = scheduledData.scheduledOnDate[date]![index];
      if (task.timeReminded != null) {
        cancelNotification(int.parse(task.timeReminded!.day.toString() +
            task.timeReminded!.month.toString() +
            task.timeReminded!.year.toString() +
            task.timeReminded!.hour.toString() +
            task.timeReminded!.minute.toString()));
      }
      scheduledData.scheduledOnDate[date]!.removeAt(index);
      _scheduledOnDate = scheduledData.scheduledOnDate[date] ?? [];
    });
    scheduledData.updateData();
  }

  Future<void> selectDate() async {
    DateTime? datepicked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now().add(const Duration(days: -365)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (datepicked != null) {
      setState(() {
        _selectedDate = datepicked;
        _scheduledOnDate =
            scheduledData.scheduledOnDate[_selectedDate]?.where((element) {
                  var title = element.title.toLowerCase();
                  var category = element.category;
                  if (_selectedCategory == "All") {
                    return title.contains(_searchText);
                  } else {
                    return title.contains(_searchText) &&
                        category == _selectedCategory;
                  }
                }).toList() ??
                [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> catList = [
      "All",
      "Work",
      "Study",
      "Life",
      "Personal",
      "Other",
    ];
    return Padding(
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
                    DateFormat.yMMMMEEEEd().format(DateTime.now()),
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
                ],
              ),
              GestureDetector(
                onTap: createNewTask,
                child: Container(
                  height: 50,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMd().format(_selectedDate) ==
                        DateFormat.yMMMd().format(DateTime.now())
                    ? "Today Schedules :"
                    : "${DateFormat.yMMMd().format(_selectedDate)} Schedules :",
                style: GoogleFonts.robotoSlab(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: () {
                  selectDate();
                },
                icon: const Icon(Icons.calendar_today_outlined,
                    color: Color.fromARGB(255, 2, 196, 124)),
              ),
            ],
          ),
          Row(
            children: [
              DropdownMenu<String>(
                inputDecorationTheme: InputDecorationTheme(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                width: 140,
                label: const Text("Category"),
                initialSelection: catList.first,
                onSelected: (String? value) {
                  setState(() {
                    _selectedCategory = value!;
                    if (value == "All") {
                      _scheduledOnDate = scheduledData
                              .scheduledOnDate[_selectedDate]
                              ?.where((element) {
                            var title = element.title.toLowerCase();
                            return title.contains(_searchText);
                          }).toList() ??
                          [];
                    } else {
                      _scheduledOnDate = scheduledData
                              .scheduledOnDate[_selectedDate]
                              ?.where((element) {
                            var title = element.title.toLowerCase();
                            var category = element.category;
                            return title.contains(_searchText) &&
                                category == _selectedCategory;
                          }).toList() ??
                          [];
                    }
                  });
                },
                dropdownMenuEntries: catList
                    .map((e) => DropdownMenuEntry<String>(
                          value: e,
                          label: e,
                          leadingIcon: switch (e) {
                            "All" =>
                              const Icon(Icons.all_out, color: Colors.black),
                            "Work" =>
                              const Icon(Icons.work, color: Colors.black),
                            "Study" =>
                              const Icon(Icons.book, color: Colors.black),
                            "Life" =>
                              const Icon(Icons.favorite, color: Colors.black),
                            "Personal" =>
                              const Icon(Icons.person, color: Colors.black),
                            "Other" =>
                              const Icon(Icons.more_horiz, color: Colors.black),
                            String() => null,
                          },
                        ))
                    .toList(),
                requestFocusOnTap: false,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      _searchText = text;
                      _scheduledOnDate = scheduledData
                              .scheduledOnDate[_selectedDate]
                              ?.where((element) {
                            var title = element.title.toLowerCase();
                            var category = element.category;
                            if (_selectedCategory == "All") {
                              return title.contains(_searchText);
                            } else {
                              return title.contains(_searchText) &&
                                  category == _selectedCategory;
                            }
                          }).toList() ??
                          [];
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 196, 124)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _scheduledOnDate.isNotEmpty
                ? ListView.builder(
                    itemCount: _scheduledOnDate.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            taskDetail(_scheduledOnDate[index]);
                          },
                          child: ScheduledTile(
                            schedule: _scheduledOnDate[index],
                            taskCompleted: _scheduledOnDate[index].isDone,
                            onChanged: (value) {
                              checkBoxChanged(value, index, _selectedDate);
                            },
                            deleteFunction: (context) {
                              deleteTask(index, _selectedDate);
                            },
                          ));
                    },
                  )
                : Center(
                    child: Text(
                      "No Scheduled${_selectedDate == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ? " Today" : " on ${DateFormat.yMMMd().format(_selectedDate)}"}",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
