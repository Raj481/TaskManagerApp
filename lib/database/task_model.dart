class TaskModel {
  int? id;
  String title;
  String description;

  TaskModel({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}