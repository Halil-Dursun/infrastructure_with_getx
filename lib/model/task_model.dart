

import 'package:objectbox/objectbox.dart';

import 'package:local_project/model/task_item_model.dart';
import 'package:local_project/model/task_wallet_model.dart';

@Entity()
class TaskModel {
  int id =0;
  String title;
  bool isPrice;
  @Property(type: PropertyType.date)
  DateTime date;
  TaskModel({
    required this.title,
    required this.isPrice,
    required this.date,
  });

  @Backlink()
  final taskItemModeList = ToMany<TaskItemModel>();

  @Backlink()
  final walletItemModelList = ToMany<TaskWalletModel>();
}
