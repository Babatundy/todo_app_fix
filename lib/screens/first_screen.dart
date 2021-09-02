import 'package:fixingtodoapp/DB_helper/db_helper.dart';
import 'package:fixingtodoapp/models/task.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fixingtodoapp/providers/provider.dart';
import 'package:fixingtodoapp/screens/tasks_screen.dart';

class Main_screen extends StatefulWidget {
  static final animation_key = GlobalKey<AnimatedListState>();

  @override
  _Main_screenState createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen>
    with SingleTickerProviderStateMixin {
  int index = 0;

  @override
  void initState() {
    Provider.of<Task_data_provider>(context, listen: false).check_database();

    super.initState();
  }

  @override
  Widget build(BuildContext contextt) {
    return Provider.of<Task_data_provider>(context).start
        ? Scaffold(
            appBar: AppBar(
              elevation: 10,
              centerTitle: true,
              title: Text(
                "TODO",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white70,
            ),
            body: Neumorphic(
              child: ListView.builder(
                key: Main_screen.animation_key,
                itemCount:
                    Provider.of<Task_data_provider>(contextt).tasks.length,
                itemBuilder: (
                  context,
                  i,
                ) {
                  index = i;
                  Provider.of<Task_data_provider>(contextt, listen: false)
                      .tasks[i]
                      .index = index;

                  return Provider.of<Task_data_provider>(contextt).tasks[i];
                },
              ),
            ),
            floatingActionButton: NeumorphicFloatingActionButton(
              style: NeumorphicStyle(
                intensity: 1,
                oppositeShadowLightSource: true,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      transitionsBuilder: (context, animation, anim, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, anim) {
                        return Task_screen(
                          index: index,
                        );
                      }),
                );

              },
              child: Icon(Icons.add),
            ),
          )
        : CircularProgressIndicator();
  }
}
