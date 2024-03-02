import 'package:hive_flutter/hive_flutter.dart';

class Profile {
  var box = Hive.box('myBox');
  Map profileData = {};

  void initialData() {
    profileData = {
      "name": "",
      "email": "",
      "gender": "",
      "birthdate": null,
      "profilepicture": null,
    };
  }

  void loadData() {
    profileData = box.get('profileData');
  }

  void updateData() {
    box.put('profileData', profileData);
  }
}
