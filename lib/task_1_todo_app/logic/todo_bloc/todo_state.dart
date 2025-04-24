part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<TodoModel> todos;

  TodoLoaded(this.todos);
}

final class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}

final class TodoCreated extends TodoState {
  final TodoModel todo;

  TodoCreated(this.todo);
}

final class TodoUpdated extends TodoState {
  final TodoModel todo;

  TodoUpdated(this.todo);
}

final class TodoDeleted extends TodoState {
  final String id;

  TodoDeleted(this.id);
}

final class TodoCompleted extends TodoState {
  final String id;

  TodoCompleted(this.id);
}

final class TodoUncompleted extends TodoState {
  final String id;

  TodoUncompleted(this.id);
}
