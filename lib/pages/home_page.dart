import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todo_task/models/task_models.dart';
import 'package:todo_task/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allTasks = <Task>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet(context);
          },
          child: const Text(
            'What are you doing today?',
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _showAddTaskBottomSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var _oankiListeElemani = _allTasks[index];
                return Dismissible(
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Task is deleted')
                      ],
                    ),
                    key: Key(_oankiListeElemani.id),
                    onDismissed: (direction) {
                      _allTasks.removeAt(index);
                      setState(() {});
                    },
                    child: TaskItem(task: _oankiListeElemani));
              },
              itemCount: _allTasks.length,
            )
          : Center(
              child: Text('Lets add new task'),
            ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                title: TextField(
                  autofocus: true,
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration(
                      hintText: 'What is your task?', border: InputBorder.none),
                  onSubmitted: (value) {
                    Navigator.of(context).pop();
                    if (value.length > 3) {
                      DatePicker.showTimePicker(
                        context,
                        showSecondsColumn: false,
                        onConfirm: (time) {
                          var yeniEklenecekGorev =
                              Task.create(name: value, createdAt: time);
                          _allTasks.add(yeniEklenecekGorev);
                          setState(() {});
                        },
                      );
                    }
                  },
                ),
              ));
        });
  }
}
