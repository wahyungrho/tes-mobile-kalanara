class TodoModel {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      isCompleted: map['is_completed'] == 1,
    );
  }
}
