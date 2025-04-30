import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int _priority = 1;
  DateTime _selectedDate = DateTime.now();

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> task = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'priority': _priority,
        'dueDate': _selectedDate.toIso8601String(),
      };

      await DatabaseHelper.instance.insertTask(task);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarea guardada con éxito')),
      );

      Navigator.pop(context);
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    // Asegurar que pickedDate no sea null antes de asignarlo
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nueva Tarea'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título de la Tarea'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: _priority,
                items: [
                  DropdownMenuItem(value: 1, child: Text('Baja')),
                  DropdownMenuItem(value: 2, child: Text('Media')),
                  DropdownMenuItem(value: 3, child: Text('Alta')),
                ],
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Prioridad'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                      "Fecha límite: ${_selectedDate.toLocal()}".split(' ')[0]),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Seleccionar Fecha'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveTask,
                  child: Text('Guardar Tarea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
