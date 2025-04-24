import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/domain/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/domain/repositories/todo_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {});

    on<TodoGetEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await todoRepository.getTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<TodoCreateEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        await todoRepository.createTodo(event.todo);
        emit(TodoCreated(event.todo));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<TodoUpdateEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        await todoRepository.updateTodo(event.todo);
        emit(TodoUpdated(event.todo));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<TodoDeleteEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        await todoRepository.deleteTodo(event.id);
        emit(TodoDeleted(event.id));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<TodoUpdateStatusEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        await todoRepository.updateTodoStatus(event.id, event.isCompleted);
        if (event.isCompleted) {
          emit(TodoCompleted(event.id));
        } else {
          emit(TodoUncompleted(event.id));
        }
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });
  }
}
