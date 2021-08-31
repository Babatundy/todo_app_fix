import 'package:fixingtodoapp/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:fixingtodoapp/providers/provider.dart';

class Task_screen extends StatelessWidget {
  int index = 0;

  Task_screen({this.index});

  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Neumorphic(
          child: Column(
            children: [
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
                  "ADD TASK",
                  style: NeumorphicStyle(color: Colors.black),
                ),
                onPressed: () {
                  Provider.of<Task_data_provider>(context, listen: false)
                      .add_to_tasks_list(
                    Task(
                      id: Provider.of<Task_data_provider>(context, listen: false)
                          .id,
                      text: text,
                      index:
                          Provider.of<Task_data_provider>(context, listen: false)
                              .index,
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
}
