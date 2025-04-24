import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/data/local_datasources/database_service.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/domain/models/todo_model.dart';

class TodoDatabase {
  final dbService = DatabaseService();

  Future<List<TodoModel>> getTodos() async {
    final db = await dbService.database;
    final List<Map<String, dynamic>> query = await db.query(
      'todos',
      orderBy: 'created_at DESC',
    ); // 0 for false, 1 for true
    return query.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<void> createTodo(TodoModel todo) async {
    final db = await dbService.database;
    await db.insert('todos', todo.toMap());
  }

  Future<void> updateTodo(TodoModel todo) async {
    final db = await dbService.database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    final db = await dbService.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  // update the is_completed field of a todo
  Future<void> updateTodoStatus(String id, bool isCompleted) async {
    final db = await dbService.database;
    await db.update(
      'todos',
      {'is_completed': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
