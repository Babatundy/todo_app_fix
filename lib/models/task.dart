import 'package:flutter/material.dart';
import 'package:fixingtodoapp/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Task extends StatefulWidget {
  int id, index;
  String text;
  bool checked;

  Task({
    this.id,
    this.text,
    this.checked = false,
    this.index,
  });

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> with TickerProviderStateMixin {
  AnimationController controller, controller2;

  Animation fade_in, fade_out;
  double start = 0, end = 1;
  bool fade_out_bool = true;

  @override
  void initState() {
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
        ),
      ),
    );
  }
}
