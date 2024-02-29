import 'package:hive_flutter/hive_flutter.dart';

class Profile {
  var box = Hive.box('myBox');
  List profileData = [];

  void initialData() {
    profileData = [
      "",
      "",
      "",
      null,
      null,
    ]; //name, email, gender, birthdate, profilepicture
  }

  void loadData() {
    profileData = box.get('profileData');
  }

  void updateData() {
    box.put('profileData', profileData);
  }
}
