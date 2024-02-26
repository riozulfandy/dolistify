import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dolistify/ui/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class EditPofilePage extends StatefulWidget {
  final Function(int) onButtonPressed;
  final Function() onEditProfile;
  const EditPofilePage(
      {Key? key, required this.onButtonPressed, required this.onEditProfile})
      : super(key: key);

  @override
  State<EditPofilePage> createState() => EditPofilePageState();
}

class EditPofilePageState extends State<EditPofilePage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String _name = "";
  String _email = "";
  String _gender = "";
  DateTime? _birthdate;
  final List<String> _genderList = ["Male", "Female"];
  final TextEditingController _birthdateController = TextEditingController(
      text: birthdate != null ? DateFormat.yMMMMd().format(birthdate!) : "");

  void selectImageGallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(img!.path);
    });
  }

  void getImageFromCamera() async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(img!.path);
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery',
                style: TextStyle(color: Color.fromARGB(255, 2, 196, 124))),
            onPressed: () {
              Navigator.of(context).pop();
              selectImageGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera',
                style: TextStyle(color: Color.fromARGB(255, 2, 196, 124))),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  void saveProfile() async {
    if (_gender == "" && gender == "") {
      _gender = "Male";
    }
    if (_gender == "" && !(gender == "")) {
      _gender = gender;
    }
    if (_name == "" && !(name == "")) {
      _name = name;
    }
    if (_email == "" && !(email == "")) {
      _email = email;
    }
    name = _name;
    email = _email;
    gender = _gender;
    profileImage = _image != null ? Image.file(_image!) : profileImage;
    birthdate = _birthdate ?? birthdate;
  }

  Future<void> selectDate() async {
    DateTime? datepicked = await showDatePicker(
        context: context,
        initialDate: birthdate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (datepicked != null) {
      setState(() {
        _birthdate = datepicked;
      });
      _birthdateController.text = DateFormat.yMMMMd().format(datepicked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                name == "" ? "Create Profile" : "Edit Profile",
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
                    backgroundImage: _image != null
                        ? Image.file(_image!).image
                        : profileImage.image,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 67,
                    child: IconButton(
                      color: const Color.fromARGB(255, 2, 196, 124),
                      onPressed: () {
                        showOptions();
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: TextFormField(
                          onChanged: (String? value) {
                            setState(() {
                              _name = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Name shouldn't be empty!";
                            }
                            return null;
                          },
                          initialValue: name,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          onChanged: (String? value) {
                            setState(() {
                              _email = value!;
                            });
                          },
                          initialValue: email,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Email shouldn't be empty!";
                            }
                            if (!EmailValidator.validate(value)) {
                              return "Invalid email format!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          controller: _birthdateController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Birthdate shouldn't be empty!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: "Birthdate",
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            selectDate();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: DropdownMenu<String>(
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 40,
                          label: const Text("Gender"),
                          initialSelection: gender == "Female"
                              ? _genderList.last
                              : _genderList.first,
                          onSelected: (String? value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                          dropdownMenuEntries: _genderList
                              .map((e) => DropdownMenuEntry<String>(
                                    value: e,
                                    label: e,
                                    leadingIcon: e == "Male"
                                        ? const Icon(
                                            Icons.male,
                                            color: Colors.blue,
                                          )
                                        : const Icon(
                                            Icons.female,
                                            color: Color.fromARGB(
                                                255, 255, 97, 150),
                                          ),
                                  ))
                              .toList(),
                          requestFocusOnTap: false,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 2, 196, 124)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              saveProfile();
                              widget.onEditProfile();
                              widget.onButtonPressed(2);
                            }
                          },
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
