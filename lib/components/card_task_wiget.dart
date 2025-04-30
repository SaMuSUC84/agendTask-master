import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worklog/core/app_colors.dart';
import 'package:worklog/core/app_text_styles.dart';
import 'package:worklog/helpers/models/card_task.dart';

class CardTaskWidget extends StatelessWidget {
  final CardTask task;

  CardTaskWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          task.title.toUpperCase(),
          style: AppText.taskTitleText,
        ),
        subtitle: Text(task.description, style: AppText.taskDescpText),
        trailing: _textPriority(),
      ),
      surfaceTintColor: AppColor.cards,
    );
  }

  Text _textPriority() {
    DateTime _dateTask = DateTime.parse(task.dueDate);
    String _dateTaskFormat = DateFormat('dd/MM/yyyy').format(_dateTask);
    Color? _color;
    int _priority = task.priority;
    String _priorityText = "";

    if (_priority == 1) {
      _priorityText = "Baja: " + "${_dateTaskFormat}";
      _color = AppColor.lowPriority;
    } else if (_priority == 2) {
      _priorityText = "Media: " + "${_dateTaskFormat}";
      _color = AppColor.mediumPriority;
    } else if (_priority == 3) {
      _priorityText = "Alta: " + "${_dateTaskFormat}";
      _color = AppColor.highPriority;
    } else if (_priority == 0) {
      _priorityText = "Finalizada:  " + "${_dateTaskFormat}";
      _color = AppColor.endTask;
    }

    return Text(_priorityText,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: _color));
  }
}
