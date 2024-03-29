import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dolistify/ui/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "scheduled_notifications",
      channelName: "Scheduled Notifications",
      channelDescription: "Scheduled Notifications Channel",
      defaultColor: const Color.fromARGB(255, 2, 196, 124),
      importance: NotificationImportance.High,
      channelShowBadge: true,
      criticalAlerts: true,
    )
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch:
                getMaterialColor(const Color.fromARGB(255, 2, 196, 124))),
      ),
      home: const SplashScreen(),
    );
  }
}
