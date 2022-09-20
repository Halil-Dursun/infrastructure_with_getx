import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_project/main.dart';
import 'package:local_project/model/task_model.dart';
import 'package:local_project/model/task_wallet_model.dart';

import '../utils/project_colors.dart';

class WalletDetailPageController extends GetxController {
  TextEditingController walletTitleController = TextEditingController();
  TextEditingController walletDescriptionController = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();

  RxList<TaskWalletModel> showList = <TaskWalletModel>[].obs;
  RxDouble totalAmount = 0.0.obs;

  void calculateTotalAmount(){
    double calculatingAmount = 0;
    for (var element in showList) {
      if (element.isEarn) {
        calculatingAmount += element.amount;
      }else{
        calculatingAmount -= element.amount;
      }
    }
   totalAmount.value = calculatingAmount; 
  }

  void clearControllers(){
    walletTitleController.clear();
    walletDescriptionController.clear();
    walletAmountController.clear();
  }

  RxBool isEarn = true.obs;

  void changeIsEarn(bool value) {
    isEarn.value = value;
  }

  

  void addWalletModelToList(TaskModel taskModel) {
    TaskWalletModel model = TaskWalletModel(
        title: walletTitleController.text,
        description: walletDescriptionController.text,
        amount: double.parse(walletAmountController.text),
        isEarn: isEarn.value,
        date: DateTime.now());
    //showList.add(model);
    taskModel.walletItemModelList.add(model);
    objectBox.taskBox.put(taskModel);
    clearControllers();
    calculateTotalAmount();
    Get.back();
    Get.snackbar('data_added_success'.tr, 'wallet_data_added_success'.tr,backgroundColor: ProjectColor.greenColor);
  }
  void deleteWalletModelToList(TaskModel taskModel,TaskWalletModel walletModel){
    taskModel.walletItemModelList.remove(walletModel);
    objectBox.taskBox.put(taskModel);
    calculateTotalAmount();
    Get.snackbar('data_deleted_success'.tr, 'wallet_data_deleted_success'.tr,backgroundColor: ProjectColor.redColor);
  }
  void updateWalletModelToList(TaskModel taskModel, TaskWalletModel walletModel){
    // final index = taskModel.walletItemModelList.indexWhere((element) => element.id == walletModel.id);
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
    //taskModel.walletItemModelList.remove(walletModel);
    walletModel.title = walletTitleController.text;
    walletModel.description = walletDescriptionController.text;
    walletModel.amount = double.parse(walletAmountController.text);
    walletModel.isEarn = isEarn.value;
    taskModel.walletItemModelList.add(walletModel);
    objectBox.taskBox.put(taskModel);
    showList.remove(walletModel);
    clearControllers();
    calculateTotalAmount();
    Get.back();
    Get.snackbar('data_updated_success'.tr, 'wallet_data_updated_success'.tr,backgroundColor: ProjectColor.darkBlueColor);
  }
}
