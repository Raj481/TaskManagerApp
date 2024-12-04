import 'package:flutter/material.dart';
import 'package:onlinetask/database/task_model.dart';

class TaskForm extends StatefulWidget {
  final void Function(TaskModel) onAddTask;

  const TaskForm({required this.onAddTask, super.key});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          ElevatedButton(
            onPressed: () {
              final newTask = TaskModel(
                title: _titleController.text,
                description: _descriptionController.text,
              );
              widget.onAddTask(newTask);
              Navigator.pop(context);
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}