import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fixingtodoapp/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Task extends StatefulWidget {
  int id, index;
  String text;
  bool checked;
  DateTime dateTime;

  Task({this.id, this.text, this.checked = false, this.index, this.dateTime});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> with TickerProviderStateMixin {
  AnimationController controller, controller2;
  FlutterLocalNotificationsPlugin localNotifications= FlutterLocalNotificationsPlugin();
  Animation fade_in, fade_out;
  double start = 0, end = 1;
  bool fade_out_bool = true;

  var android_details = new AndroidNotificationDetails(
      "k", "Reminder", "reminder",
      importance: Importance.high);
  var general_details;

  Future show_notification() async {
    //--------------------------------------------
    try {
      return await localNotifications.schedule(
        0,
        'GET IT DONE!!!',
        widget.text,
        widget.dateTime,
        general_details,
        androidAllowWhileIdle: true,
      );
    } catch (e) {
      print(e);
    }

  }

  @override
  void initState() {
    general_details =  NotificationDetails(android: android_details);
    //initilising timezone
   // tz.initializeTimeZones();
    //start schadualed notification
    show_notification();
    //setting up notification system
    /*  var androidInit = new AndroidInitializationSettings("ic_launcher");
    var initialazationSettings =
        new InitializationSettings(android: androidInit);
    localNotifications = new FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initialazationSettings);
*/
    //setting up animations
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    // TODO: implement initState
    fade_in = Tween<double>(begin: start, end: end).animate(controller);
    controller.forward();
    fade_out = Tween<double>(begin: end, end: start).animate(controller2);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade_out_bool ? fade_out : fade_in,
      child: Neumorphic(
        child: ListTile(
          leading: ChangeNotifierProvider(
            create: (_) => Task_data_provider(),
            builder: (context, child) {
              return Container(
                width: 70,
                child: NeumorphicCheckbox(
                  value: widget.checked,
                  onChanged: (b) {
                    setState(() {
                      widget.checked = b;
                      Provider.of<Task_data_provider>(context, listen: false)
                          .check_task(b, widget.id);
                    });
                  },
                ),
              );
            },
          ),
          onLongPress: () {
            //todo:remove allarm when done

            controller2.forward();
            Future ft = Future(() {});
            ft = ft.then((value) {
              return Future.delayed(Duration(seconds: 1), () {
                Provider.of<Task_data_provider>(context, listen: false)
                    .remove_tasks_from_list(widget.index);
                setState(() {
                  fade_out_bool = true;
                  controller2.reverse();
                });
              });
            });
          },
          title: Text(widget.text),
          subtitle: Text(widget.dateTime.toString()),
        ),
      ),
    );
  }
}
