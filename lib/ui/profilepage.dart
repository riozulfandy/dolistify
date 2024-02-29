import 'dart:typed_data';

import 'package:dolistify/data/profile_data.dart';
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
  String name = "";
  String email = "";
  String gender = "";
  DateTime? birthdate;
  Uint8List? profileImage;
  @override
  void initState() {
    super.initState();
    profile.loadData();
    name = profile.profileData[0];
    email = profile.profileData[1];
    gender = profile.profileData[2];
    birthdate = profile.profileData[3];
    profileImage = profile.profileData[4];
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
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImage != null
                      ? Image.memory(profileImage!).image
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  gender == 'Female' ? Icons.female : Icons.male,
                  color: gender == 'Female'
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
                  email,
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
                  DateFormat.yMMMMd().format(birthdate!),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
