import 'package:fixingtodoapp/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fixingtodoapp/providers/provider.dart';

class Task_screen extends StatelessWidget {
  int index = 0;

  Task_screen({this.index});

  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("task screen"),
      ),
      body: Column(
        children: [
          TextField(
            autofocus: true,
            onChanged: (s) {
              text = s;
            },
          ),
          RaisedButton(
            onPressed: () {
              Provider.of<Task_data_provider>(context, listen: false)
                  .add_to_tasks_list(
                Task(
                  id: Provider.of<Task_data_provider>(context, listen: false)
                      .id,
                  text: text,
                  index: Provider.of<Task_data_provider>(context, listen: false).index,
                ),
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
