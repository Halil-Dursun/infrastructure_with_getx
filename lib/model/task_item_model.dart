

import 'package:local_project/model/task_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TaskItemModel{
  int id = 0;
  String title;
  String description;
  bool isComplate;
  @Property(type: PropertyType.date)
  DateTime date;

  final purseModel = ToOne<TaskModel>();
  
  TaskItemModel({
    required this.title,
    required this.description,
    required this.date,
    this.isComplate = false,
  });
}