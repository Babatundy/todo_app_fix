import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fixingtodoapp/providers/provider.dart';
import 'package:fixingtodoapp/screens/tasks_screen.dart';

class Main_screen extends StatelessWidget {
  int index = 0;

  @override
  Widget build(BuildContext contextt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todo"),
      ),
      body: ListView.builder(
        itemCount: Provider.of<Task_data_provider>(contextt).tasks.length,
        itemBuilder: (context, i) {

          index = i;
          Provider.of<Task_data_provider>(contextt,listen: false).tasks[i].index=index;

          return Provider.of<Task_data_provider>(contextt).tasks[i];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            contextt,
            MaterialPageRoute(
              builder: (context) {
                return Task_screen(
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
