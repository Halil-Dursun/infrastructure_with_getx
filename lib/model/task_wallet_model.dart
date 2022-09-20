

import 'package:local_project/model/task_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TaskWalletModel{
  int id = 0;
  String title;
  String description;
  double amount;
  bool isEarn;
  @Property(type: PropertyType.date)
  DateTime date;

  final purseModel = ToOne<TaskModel>();
  
  TaskWalletModel({
    required this.title,
    required this.description,
    required this.amount,
    required this.isEarn,
    required this.date,
  });
}