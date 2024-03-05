import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dolistify/data/profile_data.dart';
import 'package:dolistify/data/scheduled_data.dart';
import 'package:dolistify/data/scheduled_model.dart';
import 'package:dolistify/data/todo_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final Function(int) moveTab;
  const HomePage({Key? key, required this.moveTab}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _box = Hive.box('myBox');
  ToDoData toDoData = ToDoData();
  Profile profile = Profile();
  ScheduledData scheduledData = ScheduledData();
  ScheduledItem? nextSchedule;

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((value) => {
          if (!value)
            {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey.shade50,
                  surfaceTintColor: Colors.grey.shade50,
                  title: Text(
                    'Allow Notifications',
                    style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  content: Text(
                    'This app would like to send notifications',
                    style: GoogleFonts.poppins(
                      textStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Don\'t Allow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.of(context).pop());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color.fromARGB(255, 2, 196, 124),
                      ),
                      child: const Text(
                        'Allow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                  actionsPadding: const EdgeInsets.only(right: 20, bottom: 20),
                ),
              )
            }
        });

    if (_box.get('todoList') == null) {
      toDoData.initialData();
      toDoData.updateData();
    } else {
      toDoData.loadData();
    }
    if (_box.get('scheduledOnDate') == null) {
      scheduledData.initialData();
      scheduledData.updateData();
    } else {
      scheduledData.loadData();
    }
    if (_box.get("profileData") == null) {
      profile.initialData();
    } else {
      profile.loadData();
    }
    bool getFirst = false;
    for (var schedule in scheduledData.scheduledOnDate[DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day)]!) {
      if (!getFirst &&
          schedule.timeStarted.isAfter(DateTime.now()) &&
          schedule.isDone == false) {
        nextSchedule = schedule;
        getFirst = true;
      }
      if (nextSchedule != null &&
          schedule.timeStarted.isBefore(nextSchedule!.timeStarted) &&
          schedule.isDone == false) {
        nextSchedule = schedule;
      }
    }
  }

  void createToDo() {
    final formKey = GlobalKey<FormState>();
    TextEditingController textFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor: Colors.grey.shade50,
            surfaceTintColor: Colors.grey.shade50,
            title: Text(
              'New To Do',
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            content: TextFormField(
              controller: textFieldController,
              decoration: InputDecoration(
                hintText: "Enter To Do",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a task';
                }
                return null;
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      toDoData.todoList.add([textFieldController.text, false]);
                      toDoData.updateData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('To Do Added'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 2, 196, 124),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            actionsPadding: const EdgeInsets.only(right: 20, bottom: 20),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
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
            'Welcome, ${profile.profileData.isEmpty ? '' : profile.profileData["name"].split(' ')[0]}',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 196, 124),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Material(
            borderRadius: BorderRadius.circular(24),
            elevation: 4,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), // Set border radius
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 2, 196, 124),
                    Color.fromRGBO(55, 122, 59, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 25, bottom: 20),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset('assets/images/homepage_draw.png'),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Make your Life\nProductive',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        decoration: ShapeDecoration(
                          color: const Color(0x26D2D2D2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.29),
                          ),
                        ),
                        width: 100,
                        height: 25,
                        child: InkWell(
                          onTap: () {
                            widget.moveTab(1);
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Get Started",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(
              Icons.calendar_today,
              color: Color.fromARGB(255, 2, 196, 124),
            ),
            title: Text(
              'Next Schedule :',
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 2, 196, 124),
              ),
              gradient: const LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Color.fromARGB(255, 163, 255, 201),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (nextSchedule != null) ...[
                Text(
                  nextSchedule!.title,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                      DateFormat.Hm().format(nextSchedule!.timeStarted),
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
                      nextSchedule!.timeReminded == null
                          ? "None"
                          : nextSchedule!.timeReminded!
                                      .difference(nextSchedule!.timeStarted)
                                      .inMinutes ==
                                  -5
                              ? "5 minutes before"
                              : nextSchedule!.timeReminded!
                                          .difference(nextSchedule!.timeStarted)
                                          .inMinutes ==
                                      -15
                                  ? "15 minutes before"
                                  : nextSchedule!.timeReminded!
                                              .difference(
                                                  nextSchedule!.timeStarted)
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
              ] else ...[
                Center(
                  child: Text(
                    'No Schedule',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ]),
          ),
          ListTile(
            leading: const Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 2, 196, 124),
            ),
            title: Text(
              'Quick To Do :',
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            trailing: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 2, 196, 124),
              ),
              child: IconButton(
                onPressed: () {
                  createToDo();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 563,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 2, 196, 124),
              ),
            ),
            child: toDoData.todoList.isNotEmpty
                ? ListView.separated(
                    itemCount: toDoData.todoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                          activeColor: const Color.fromARGB(255, 2, 196, 124),
                          value: toDoData.todoList[index][1],
                          onChanged: (value) {
                            setState(() {
                              toDoData.todoList[index][1] = value!;
                              toDoData.updateData();
                            });
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              toDoData.todoList.removeAt(index);
                              toDoData.updateData();
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        title: Text(
                          toDoData.todoList[index][0],
                          style: TextStyle(
                            decoration: toDoData.todoList[index][1]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No ToDo',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 15,
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
