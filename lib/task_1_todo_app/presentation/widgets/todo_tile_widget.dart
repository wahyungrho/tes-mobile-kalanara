import 'package:flutter/material.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/domain/models/todo_model.dart';

class TodoTileWidget extends StatelessWidget {
  final TodoModel? todo;
  final Function(String)? onUpdate;
  final Function(String)? onDelete;
  final Function(String, bool)? onUpdateStatus;
  const TodoTileWidget({
    super.key,
    this.todo,
    this.onUpdate,
    this.onDelete,
    this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo?.id ?? ''),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        if (onDelete != null) {
          onDelete!(todo?.id ?? '');
        }
      },
      child: ListTile(
        title: Text(
          todo?.title ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration:
                todo?.isCompleted == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
          ),
        ),
        subtitle: Text(todo?.description ?? ''),
        trailing: Checkbox(
          value: todo?.isCompleted,
          onChanged: (value) {
            if (onUpdateStatus != null) {
              onUpdateStatus!(todo?.id ?? '', value ?? false);
            }
          },
        ),
        onTap: () {
          if (onUpdate != null) {
            onUpdate!(todo?.id ?? '');
          }
        },
      ),
    );
  }
}
