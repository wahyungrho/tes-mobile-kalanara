import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/data/local_datasources/todo_database.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/domain/models/todo_model.dart';

class TodoRepository {
  final TodoDatabase todoDatabase = TodoDatabase();

  Future<List<TodoModel>> getTodos() async {
    return await todoDatabase.getTodos();
  }

  Future<void> createTodo(TodoModel todo) async {
    await todoDatabase.createTodo(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await todoDatabase.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await todoDatabase.deleteTodo(id);
  }

  Future<void> updateTodoStatus(String id, bool isCompleted) async {
    await todoDatabase.updateTodoStatus(id, isCompleted);
  }
}
