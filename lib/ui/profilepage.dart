import 'dart:typed_data';

import 'package:dolistify/data/profile_data.dart';
import 'package:dolistify/widget/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final Function(int) onButtonPressed;
  final Function() onEditProfile;
  const ProfilePage(
      {Key? key, required this.onButtonPressed, required this.onEditProfile})
      : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Profile profile = Profile();
  String _name = "";
  String _email = "";
  String _gender = "";
  DateTime? _birthdate;
  Uint8List? _profileImage;
  @override
  void initState() {
    super.initState();
    profile.loadData();
    _name = profile.profileData["name"];
    _email = profile.profileData["email"];
    _gender = profile.profileData["gender"];
    _birthdate = profile.profileData["birthdate"];
    _profileImage = profile.profileData["profilepicture"];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Profile",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 196, 124))),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? Image.memory(_profileImage!).image
                        : Image.asset("assets/images/profile.png").image,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 67,
                    child: IconButton(
                      color: const Color.fromARGB(255, 2, 196, 124),
                      onPressed: () {
                        widget.onEditProfile();
                        widget.onButtonPressed(2);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    _gender == 'Female' ? Icons.female : Icons.male,
                    color: _gender == 'Female'
                        ? const Color.fromARGB(255, 255, 97, 150)
                        : Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cake,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat.yMMMMd().format(_birthdate!),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Material(
                elevation: 4,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 2, 196, 124),
                        Color.fromRGBO(55, 122, 59, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your Weekly Progress',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Today: ${DateFormat.EEEE().format(DateTime.now())}',
                        style: GoogleFonts.robotoSlab(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const BarChartSample3(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
