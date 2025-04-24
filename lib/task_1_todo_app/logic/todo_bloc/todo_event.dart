part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class TodoGetEvent extends TodoEvent {}

final class TodoCreateEvent extends TodoEvent {
  final TodoModel todo;

  TodoCreateEvent(this.todo);
}

final class TodoUpdateEvent extends TodoEvent {
  final TodoModel todo;

  TodoUpdateEvent(this.todo);
}

final class TodoDeleteEvent extends TodoEvent {
  final String id;

  TodoDeleteEvent(this.id);
}

final class TodoUpdateStatusEvent extends TodoEvent {
  final String id;
  final bool isCompleted;

  TodoUpdateStatusEvent(this.id, this.isCompleted);
}
