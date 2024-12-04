import 'package:flutter/material.dart';
import 'package:onlinetask/database/task_model.dart';

class TaskListItem extends StatefulWidget {
  final TaskModel task;
  final bool showTraling;
  final void Function(TaskModel) onDelete;
  final void Function(TaskModel) onEdit;

  TaskListItem({required this.task, this.showTraling = true, required this.onDelete, super.key, required this.onEdit});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.task.title),
        subtitle: Text(widget.task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.showTraling ? [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.red),
              onPressed: (){
                widget.onEdit(widget.task);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => widget.onDelete(widget.task),
            )
          ] : [],
        ),
      ),
    );
  }


}