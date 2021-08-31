import 'package:flutter/material.dart';
import 'package:fixingtodoapp/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Task extends StatefulWidget {
  int id, index;
  String text;
  bool checked;

  Task({this.id, this.text, this.checked = false, this.index});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(

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
                  });
                  Provider.of<Task_data_provider>(context, listen: false)
                      .check_task(b, widget.id);
                },
              ),
            );/* Checkbox(
              value: widget.checked,
              onChanged: (b) {
                setState(() {
                  widget.checked = b;
                });
                Provider.of<Task_data_provider>(context, listen: false)
                    .check_task(b, widget.id);
              },
            );*/

          },
        ),
        onLongPress: () {
          Provider.of<Task_data_provider>(context, listen: false)
              .remove_tasks_from_list(widget.index);
          //todo:delete task
        },
        title: Text(widget.text),
      ),
    );
  }
}
