import 'package:flutter/material.dart';
import 'package:worklog/components/card_task_wiget.dart';
import 'package:worklog/core/app_text_styles.dart';
import 'package:worklog/helpers/database_helper.dart';
import 'package:worklog/helpers/models/card_task.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  @override
  _PendingTaskState createState() => _PendingTaskState();
}

class _PendingTaskState extends State<PendingTaskScreen> {
  Future<List<CardTask>> _loadTasks() async {
    final _tasks = await DatabaseHelper.instance.getTasks();
    return _tasks.map((map) => CardTask.fromMap(map)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
      child: Center(
        child: cardListBuilder(),
      ),
    );
  }

  // Método para la creacion de cards.
  FutureBuilder<List<CardTask>> cardListBuilder() {
    return FutureBuilder<List<CardTask>>(
        future: _loadTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final tasks = snapshot.data!;
          return tasks.isEmpty
              ? Center(
                  child: Text(
                  'No hay tareas aún',
                  style: AppText.taskTitleText,
                ))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) =>
                      CardTaskWidget(task: tasks[index]));
        });
  }
}
