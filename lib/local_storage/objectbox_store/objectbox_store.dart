

import 'package:local_project/model/task_model.dart';
import 'package:local_project/objectbox.g.dart';

class ObjectBoxStore{
  late final Store _store;
  late final Box<TaskModel> _taskBox;

  Box<TaskModel> get taskBox => _taskBox;


  ObjectBoxStore._init(this._store){
    _taskBox = Box<TaskModel>(_store);
  }

  static Future<ObjectBoxStore> init() async{
    final store = await openStore();
    return ObjectBoxStore._init(store);
  }

  int insertTask(TaskModel purse) => _taskBox.put(purse);
  bool deleteTask(int id) => _taskBox.remove(id);
  Stream<List<TaskModel>> getPurse() => _taskBox.query().watch(triggerImmediately: true).map((query)=> query.find());

}