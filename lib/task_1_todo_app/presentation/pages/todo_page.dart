import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/domain/models/todo_model.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/logic/todo_bloc/todo_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/presentation/widgets/text_field_widget.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/presentation/widgets/todo_tile_widget.dart';
import 'package:flutter_tes_mobile_kalanara_group/utils.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  bool _isCompleted = false;

  void _showFormBottomSheet(String? id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  'Form Todo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // subtitle
                const SizedBox(height: 4),
                const Text(
                  'Please fill in the form below',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  controller: _titleController,
                  label: 'Title',
                  hintText: 'Enter your title',
                  focusNode: _titleFocusNode,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                TextFieldWidget(
                  controller: _descriptionController,
                  label: 'Description',
                  hintText: 'Enter your description',
                  focusNode: _descriptionFocusNode,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                id != null
                    ?
                    // iscompleted status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Completed'),
                            StatefulBuilder(
                              builder:
                                  (context, setStateSwitch) => Switch(
                                    value: _isCompleted,
                                    onChanged: (value) {
                                      setStateSwitch(() {
                                        _isCompleted = value;
                                      });
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        final todo = TodoModel(
                          id: id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          isCompleted: id != null ? _isCompleted : false,
                        );

                        if (id == null) {
                          context.read<TodoBloc>().add(TodoCreateEvent(todo));
                        } else {
                          context.read<TodoBloc>().add(TodoUpdateEvent(todo));
                        }
                        Navigator.pop(context);
                        _getTodos();
                      }
                    },
                    child: BlocListener<TodoBloc, TodoState>(
                      listener: (context, state) {
                        if (state is TodoError) {
                          Utils.showToastError(context, state.message);
                        } else if (state is TodoCreated) {
                          Utils.showToastSuccess(
                            context,
                            'Todo created successfully',
                          );
                        } else if (state is TodoUpdated) {
                          Utils.showToastSuccess(
                            context,
                            'Todo updated successfully',
                          );
                        }
                      },
                      child: BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          if (state is TodoLoading) {
                            return const CupertinoActivityIndicator(
                              color: Colors.white,
                            );
                          }
                          return const Text('Save');
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _getTodos() {
    context.read<TodoBloc>().add(TodoGetEvent());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTodos();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const CupertinoActivityIndicator(color: Colors.white);
          } else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(child: Text('No todos found'));
            }
            return Column(
              children: [
                // box information update or delete step
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    'Tap on a todo to update and swipe left to delete',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return TodoTileWidget(
                        todo: todo,
                        onUpdate: (id) {
                          _titleController.text = todo.title;
                          _descriptionController.text = todo.description;
                          _showFormBottomSheet(todo.id);
                        },
                        onDelete: (id) {
                          context.read<TodoBloc>().add(TodoDeleteEvent(id));
                          _getTodos();
                          Utils.showToastSuccess(
                            context,
                            'Todo deleted successfully',
                          );
                        },
                        onUpdateStatus: (id, isCompleted) {
                          context.read<TodoBloc>().add(
                            TodoUpdateStatusEvent(id, isCompleted),
                          );
                          _getTodos();
                          Utils.showToastSuccess(
                            context,
                            isCompleted
                                ? 'Todo marked as completed'
                                : 'Todo marked as uncompleted',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          _titleController.clear();
          _descriptionController.clear();
          _showFormBottomSheet(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
