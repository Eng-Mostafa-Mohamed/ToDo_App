import 'package:todo_app/core/Utils.dart';

class Task_Model {
  static const String CollectionName = "TasksCollection";
  String title;
  String description;
  bool is_completed;
  DateTime selected_date;
  String? id;

  Task_Model(
      {required this.title, required this.description, this.is_completed = false, required this.selected_date, this.id});

  factory Task_Model.fromfirestore(Map<String, dynamic> json) =>
      Task_Model(
          title: json['title'],
          description: json['description'],
          is_completed: json['is_completed'] ,
          selected_date: DateTime.fromMillisecondsSinceEpoch(json['selected_date']),
          id: json['id']);

  Map<String, dynamic> ToFirestore() {
    return {
      'title': title,
      'description': description,
      'is_completed': is_completed,
      'selected_date': ExtractDate(selected_date).millisecondsSinceEpoch   ,
      'id': id
    };
  }

}