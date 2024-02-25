import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Function(int) onButtonPressed;
  final Function() onEditProfile;
  const ProfilePage(
      {Key? key, required this.onButtonPressed, required this.onEditProfile})
      : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

String name = '';
String email = '';
String gender = '';
DateTime? birthdate;

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.png'),
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
                  birthdate.toString().split(' ')[0],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    ));
  }
}
