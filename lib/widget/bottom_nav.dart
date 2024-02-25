import 'package:dolistify/ui/edit_profile.dart';
import 'package:dolistify/ui/homepage.dart';
import 'package:dolistify/ui/profilepage.dart';
import 'package:dolistify/ui/scheduled.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  bool _isEdit = false;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _changeEdit() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (name == "") {
      _isEdit = true;
    }
    var tabs = _isEdit
        ? [
            const HomePage(),
            const ScheduledPage(),
            EditPofilePage(
              onButtonPressed: _changeTab,
              onEditProfile: _changeEdit,
            ),
          ]
        : [
            const HomePage(),
            const ScheduledPage(),
            ProfilePage(
              onButtonPressed: _changeTab,
              onEditProfile: _changeEdit,
            ),
          ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: SizedBox(
          width: double.infinity,
          height: 56,
          child: Image.asset('assets/images/appbar.png'),
        ),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 2, 196, 124),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          _changeTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Scheduled",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
