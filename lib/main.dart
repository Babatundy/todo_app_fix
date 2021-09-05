import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fixingtodoapp/screens/first_screen.dart';

import 'package:shake/shake.dart';
import 'package:app_launcher/app_launcher.dart';
/*ShakeDetector detector ;
void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {


    detector=ShakeDetector.autoStart(
        onPhoneShake: () async{
          await AppLauncher.openApp(
            androidApplicationId: "com.example.fixingtodoapp",
          );
        }

    );
    //simpleTask will be emitted here.
    return Future.value(true);
  });
}*/
void main() async{
 /* WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
      callbackDispatcher,
    isInDebugMode: false

  );
 Workmanager.registerOneOffTask("1", "shake");
*/
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Task_data_provider()),
      ],
      child: MaterialApp(
        initialRoute: "main_screen",
        routes: {
          "main_screen": (context) => Main_screen(),
        },
      ),
    ),
  );

  await AndroidAlarmManager.initialize();
}
