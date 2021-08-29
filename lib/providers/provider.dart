import 'package:fixingtodoapp/DB_helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:fixingtodoapp/models/task.dart';

class Task_data_provider with ChangeNotifier {
  List<Task> tasks = [];
  int id = 1;
  int index = 0;

  void add_to_tasks_list(Task t) async {
    DB_helper.instnace.insertt({
      "${DB_helper.task_checking}": "${t.checked?1:0}",
      "${DB_helper.task_text}": "${t.text}"
    });

    print( await DB_helper.instnace.Query_all());
    tasks.add(t);
    id++;
    notifyListeners();
  }

  void remove_tasks_from_list(int indexx) async {
    DB_helper.instnace.delete(tasks[indexx].id);
    print( await DB_helper.instnace.Query_all());
    tasks.removeAt(indexx);
    if (tasks.length == 0) {
      id = 1;
    }
    notifyListeners();
  }

  bool checked = false;

  void check_task(bool b,int task_id) async{

    checked = b;
    DB_helper.instnace.update(id: task_id,checked: checked?1:0);
    print( await DB_helper.instnace.Query_all());
    notifyListeners();
  }
}
