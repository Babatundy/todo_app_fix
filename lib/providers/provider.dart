import 'package:fixingtodoapp/DB_helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:fixingtodoapp/models/task.dart';

class Task_data_provider with ChangeNotifier {
  List<Task> tasks = [];
  int id = 1;
  int index = 0;

  //inserting tasks to DB and into tasks list
  void add_to_tasks_list(Task t) async {
    DB_helper.instnace.insertt({
      "${DB_helper.task_checking}": "${0}",
      "${DB_helper.task_text}": "${t.text}",
      "${DB_helper.task_reminder_date_time}":t.dateTime.toString()
    });

    tasks.add(t);
    id++;
    notifyListeners();
  }
  //when starting the app we fetch data from db only
  void add_to_tasks_list_Ui_only(Task t) async {
    tasks.add(t);
    id++;
    notifyListeners();
  }

  void remove_tasks_from_list(int indexx) async {
    DB_helper.instnace.delete(tasks[indexx].id);

    tasks.removeAt(indexx);
    if (tasks.length == 0) {
      id = 1;
    }
    notifyListeners();
  }

  bool checked = false;

  void check_task(bool b, int task_id) async {
    checked = b;
    DB_helper.instnace.update(id: task_id, checked: checked ? 1 : 0);
    notifyListeners();
  }

  bool start = false;

  //when loading data in the start of the app
  void check_database() async {
    int i = 0;
    print(await DB_helper.instnace.Query_all());
    var db_data = await DB_helper.instnace.Query_all();
    if (db_data.isNotEmpty) {
      bool task_is_checked_when_loaded;
      db_data.forEach((element) {
        if (element["checking"] == 1) {
          checked = true;
          notifyListeners();
        } else {
          checked = false;
          notifyListeners();
        }
        //connverting from string to datetime
        DateTime dateTime=DateTime.parse(element["${DB_helper.task_reminder_date_time}"]);

        add_to_tasks_list_Ui_only(
          Task(
            id: element["id"],
            text: element["text"],
            checked: checked,
            index: i,
            dateTime: dateTime,
          ),
        );
        i++;
      });
      start = true;
      notifyListeners();
    } else {
      start = true;
      notifyListeners();
    }
  }
}
