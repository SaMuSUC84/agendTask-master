import 'package:flutter/material.dart';
import 'package:worklog/components/card_task_wiget.dart';
import 'package:worklog/helpers/models/card_task.dart';
import '../helpers/database_helper.dart';

class CompletedTasksScreen extends StatefulWidget {
  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<Map<String, dynamic>> _endTasks = [];

  @override
  void initState() {
    super.initState();
    _loadEndTasks();
  }

  Future<void> _loadEndTasks() async {
    final tasks = await DatabaseHelper.instance.getEndTasks();

    setState(() {
      _endTasks = tasks.map((task) {
        return {
          ...task, // Copia todos los valores existentes
          'priority': 0 // Sobrescribe la prioridad
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CardTask> tasks =
        _endTasks.map((map) => CardTask.fromMap(map)).toList();
    return Center(
        child: _endTasks.isEmpty
            ? Center(child: Text('No hay tareas finalizadas'))
            : ListView.builder(
                itemCount: _endTasks.length,
                itemBuilder: (context, index) =>
                    CardTaskWidget(task: tasks[index])));
  }
}
