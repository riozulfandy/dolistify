import 'package:dolistify/data/profile_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
  final _box = Hive.box('myBox');
  Profile profile = Profile();
  String _name = "";
  String _email = "";
  String _gender = "";
  DateTime? _birthdate;
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    if (_box.get("profileData") == null) {
      profile.initialData();
    } else {
      profile.loadData();
    }
    _name = profile.profileData[0];
    _email = profile.profileData[1];
    _gender = profile.profileData[2];
    _birthdate = profile.profileData[3];
    _image = profile.profileData[4];
  }

  void selectImageGallery() async {
    final imgpicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final img = await imgpicked?.readAsBytes();
    setState(() {
      _image = img;
    });
  }

  void getImageFromCamera() async {
    final imgpicked = await ImagePicker().pickImage(source: ImageSource.camera);
    final img = await imgpicked?.readAsBytes();
    setState(() {
      _image = img;
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
    profile.profileData[0] = _name;
    profile.profileData[1] = _email;
    profile.profileData[2] = _gender;
    profile.profileData[3] = _birthdate;
    profile.profileData[4] = _image;
    profile.updateData();
  }

  Future<void> selectDate(birthdateController) async {
    DateTime? datepicked = await showDatePicker(
        context: context,
        initialDate: _birthdate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (datepicked != null) {
      setState(() {
        _birthdate = datepicked;
      });
      birthdateController.text = DateFormat.yMMMMd().format(datepicked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderList = ["Male", "Female"];
    final TextEditingController birthdateController = TextEditingController(
        text:
            _birthdate != null ? DateFormat.yMMMMd().format(_birthdate!) : "");

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              _box.get("profileData") == null
                  ? "Create Profile"
                  : "Edit Profile",
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
                  backgroundImage: _image == null
                      ? Image.asset("assets/images/profile.png").image
                      : Image.memory(_image!).image,
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
                      initialValue: _name,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      initialValue: _email,
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: TextFormField(
                      controller: birthdateController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Birthdate shouldn't be empty!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: "Birthdate",
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        selectDate(birthdateController);
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
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 40,
                      label: const Text("Gender"),
                      initialSelection: _gender == "Female"
                          ? genderList.last
                          : genderList.first,
                      onSelected: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                      dropdownMenuEntries: genderList
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
                                        color:
                                            Color.fromARGB(255, 255, 97, 150),
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
                            borderRadius: BorderRadius.circular(10),
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
          ],
        ),
      ),
    );
  }
}
