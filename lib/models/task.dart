import 'package:flutter/material.dart';
import 'package:fixingtodoapp/providers/provider.dart';
import 'package:provider/provider.dart';



class Task extends StatelessWidget {
  int id,index;
  String text;
  bool checked;
  Task({this.id,this.text,this.checked=false,this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ChangeNotifierProvider(
        create: (_)=>Task_data_provider(),
        builder: (context,child){
          return Checkbox(
            value: Provider.of<Task_data_provider>(context).checked,
            onChanged: (b){
              Provider.of<Task_data_provider>(context,listen: false).check_task(b,id);
            },
          );
        },

      ),
      onLongPress: (){
        Provider.of<Task_data_provider>(context,listen: false).remove_tasks_from_list(index);
        //todo:delete task
      },
      title: Text(text),
    );
  }
}
