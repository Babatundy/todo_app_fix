import 'package:fixingtodoapp/models/task.dart';
import 'package:fixingtodoapp/screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:fixingtodoapp/providers/provider.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Task_screen extends StatefulWidget {
  /*void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

  }*/

  int index = 0;

  Task_screen({this.index});

  @override
  _Task_screenState createState() => _Task_screenState();
}

class _Task_screenState extends State<Task_screen> {
  DateTime dateTime;
  TimeOfDay time;
  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Neumorphic(
          style: NeumorphicStyle(),
          child: Column(
            children: [
              Text(getText()),
              Padding(padding: EdgeInsets.all(10)),
              Neumorphic(
                style: NeumorphicStyle(
                  intensity: 1,
                  depth: -20,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(80)),
                ),
                margin: EdgeInsets.all(20),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "ENTER TASK HERE",
                    border: InputBorder.none,
                  ),
                  autofocus: true,
                  onChanged: (s) {
                    text = s;
                  },
                ),
              ),
              NeumorphicButton(
                style: NeumorphicStyle(
                  intensity: 1,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(80)),
                ),
                child: NeumorphicText(
                  "Select Reminder Time",
                  style: NeumorphicStyle(color: Colors.black),
                ),
                onPressed: () => pickDateTime(context),
              ),
              SizedBox(
                height: 20,
              ),
              NeumorphicButton(
                style: NeumorphicStyle(
                  intensity: 1,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(80)),
                ),
                child: NeumorphicText(
                  "ADD TASK",
                  style: NeumorphicStyle(color: Colors.black),
                ),
                onPressed: () {
                  Provider.of<Task_data_provider>(context, listen: false)
                      .add_to_tasks_list(
                    Task(
                      id: Provider.of<Task_data_provider>(context,
                              listen: false)
                          .id,
                      text: text,
                      index: Provider.of<Task_data_provider>(context,
                              listen: false)
                          .index,
                      dateTime: dateTime,
                    ),
                  );
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: dateTime ?? initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.black,
              accentColor: Colors.black,
              colorScheme: ColorScheme.highContrastDark(
                onSurface: Colors.black,
                primary:
                    NeumorphicColors.gradientShaderDarkColor(intensity: 0.8),
                surface: NeumorphicColors.embossDarkColor(Colors.black,
                    intensity: 0.8),
              ),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        });

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            accentColor: Colors.black,
            colorScheme: ColorScheme.highContrastDark(
                primary: NeumorphicColors.darkDisabled,
                surface: NeumorphicColors.embossDarkColor(Colors.black,
                    intensity: 0.8),
                background: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );

    if (newTime == null) return null;

    return newTime;
  }

  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return '${dateTime.month}/${dateTime.day}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
    }
  }
}
