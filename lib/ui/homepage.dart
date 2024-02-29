import 'package:dolistify/data/profile_data.dart';
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

  @override
  void initState() {
    super.initState();
    if (_box.get('todoList') == null) {
      toDoData.initialData();
      toDoData.updateData();
    } else {
      toDoData.loadData();
    }
  }

  void createToDo() {
    TextEditingController textFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
          content: TextField(
            controller: textFieldController,
            decoration: InputDecoration(
              hintText: "Enter To Do",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                  toDoData.todoList.add([textFieldController.text, false]);
                  toDoData.updateData();
                });
                Navigator.of(context).pop();
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
            DateFormat.yMMMMd().format(DateTime.now()),
            style: const TextStyle(
              color: Color.fromARGB(255, 117, 117, 117),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Welcome, ${profile.profileData.isEmpty ? '' : profile.profileData[0]}',
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
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 2, 196, 124),
              ),
            ),
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
            height: MediaQuery.of(context).size.height - 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 2, 196, 124),
              ),
            ),
            child: ListView.separated(
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
            ),
          ),
        ],
      ),
    );
  }
}
