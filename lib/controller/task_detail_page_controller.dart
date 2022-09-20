import 'package:get/get.dart';
import 'package:local_project/main.dart';
import 'package:local_project/model/task_item_model.dart';

import '../model/task_model.dart';
import '../utils/project_colors.dart';
import 'package:flutter/material.dart';

class TaskDetailPageController extends GetxController{
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  RxList<TaskItemModel> showList = <TaskItemModel>[].obs;


  void clearControllers(){
    taskTitleController.clear();
    taskDescriptionController.clear();
  }

  void addWalletModelToList(TaskModel taskModel) {
    TaskItemModel model = TaskItemModel(
        title: taskTitleController.text,
        description: taskDescriptionController.text,
        date: DateTime.now());
    //showList.add(model);
    taskModel.taskItemModeList.add(model);
    objectBox.taskBox.put(taskModel);
    clearControllers();
    Get.back();
    Get.snackbar('task_data_added_success_title'.tr, 'task_data_added_success'.tr,backgroundColor: ProjectColor.greenColor);
  }
  void deleteWalletModelToList(TaskModel taskModel,TaskItemModel taskItemModel){
    taskModel.taskItemModeList.remove(taskItemModel);
    objectBox.taskBox.put(taskModel);
    Get.snackbar('task_data_deleted_success_title'.tr, 'task_data_deleted_success'.tr,backgroundColor: ProjectColor.redColor);
  }
  void taskComplated(TaskItemModel taskItemModel, TaskModel taskModel){
    taskItemModel.isComplate = true;
    taskModel.taskItemModeList.add(taskItemModel);
    objectBox.taskBox.put(taskModel);
    showList.remove(taskItemModel);
    Get.snackbar("task_complated_title".tr, "task_complated_message".tr,backgroundColor: ProjectColor.greenColor);
  }
  void updateTaskModelToList(TaskModel taskModel, TaskItemModel taskItemModel){
    //final index = taskModel.taskItemModeList.indexWhere((element) => element.id == taskItemModel.id);
    // walletModel.title = walletTitleController.text;
    // walletModel.description = walletDescriptionController.text;
    // walletModel.amount = double.parse(walletAmountController.text);
    // walletModel.isEarn = isEarn.value;
    // taskModel.walletItemModelList.remove(walletModel);
    // taskModel.walletItemModelList.add(walletModel);
    // objectBox.taskBox.put(taskModel);
    // walletAmountController.clear();
    // walletDescriptionController.clear();
    // walletTitleController.clear();
    // Get.snackbar('data_updated_success'.tr, 'wallet_data_updated_success'.tr,backgroundColor: ProjectColor.darkBlueColor);
    // taskModel.taskItemModeList.remove(taskItemModel);
    taskItemModel.title = taskTitleController.text;
    taskItemModel.description = taskDescriptionController.text;
    taskModel.taskItemModeList.add(taskItemModel);
    // taskModel.taskItemModeList.removeAt(index);
    // taskModel.taskItemModeList.insert(index,taskItemModel);
    objectBox.taskBox.put(taskModel);
    showList.remove(taskItemModel);
    clearControllers();
    Get.back();
    Get.snackbar('task_data_updated_success_title'.tr, 'task_data_updated_success'.tr,backgroundColor: ProjectColor.darkBlueColor);

  }
}