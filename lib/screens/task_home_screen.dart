import 'package:flutter/material.dart';
import 'package:worklog/core/app_colors.dart';
import 'package:worklog/core/app_text_styles.dart';
import 'package:worklog/helpers/database_helper.dart';
import 'package:worklog/screens/task_complete_screen.dart';
import 'package:worklog/screens/task_pending_screen.dart';
import '../screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseHelper.instance.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('MiAGENDA', style: AppText.bodyText),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Próximas'.toUpperCase(), icon: Icon(Icons.pending)),
                Tab(text: 'Finalizadas'.toUpperCase(), icon: Icon(Icons.done)),
              ],
              labelColor: AppColor.primary,
              indicatorColor: AppColor.secondary,
              indicatorWeight: 3,
              indicatorAnimation: TabIndicatorAnimation.elastic,
              unselectedLabelColor: AppColor.backgrounds,
              dividerHeight: 0.5,
              dividerColor: AppColor.secondary,
            ),
          ),
          body: TabBarView(
            children: [PendingTaskScreen(), CompletedTasksScreen()],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
              await _loadTasks(); // Recargar la lista después de agregar una tarea
            },
            child: Icon(Icons.add_task),
            backgroundColor: Colors.white,
            foregroundColor: AppColor.primary,
          ),
        ));
  }
}
