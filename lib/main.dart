import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fixingtodoapp/screens/first_screen.dart';

void main() async{
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
