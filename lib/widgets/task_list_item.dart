import 'package:flutter/material.dart';
import 'package:todo_task/models/task_models.dart';
import 'package:intl/intl.dart';


class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TextEditingController _taskNameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskNameController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 10)
            ]),
        child: ListTile(
            leading: GestureDetector(
              onTap: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                setState(() {});
              },
              child: Container(
                  child: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      color:
                          widget.task.isCompleted ? Colors.green : Colors.white,
                      border: Border.all(color: Colors.white, width: 0.8),
                      shape: BoxShape.circle)),
            ),
            title: widget.task.isCompleted
                ? Text(
                    widget.task.name,
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  )
                : TextField(
                    controller: _taskNameController,
                     minLines: 1,
                     maxLines: null,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onSubmitted: (yenideger) {
                        if(yenideger.length > 3){
                      }
                    },
                ),
                trailing: Text(
                  DateFormat('hh:mm a').format(widget.task.createdAt),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              )
            );
  }
}
