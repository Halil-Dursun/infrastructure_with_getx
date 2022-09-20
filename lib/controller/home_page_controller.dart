import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_project/utils/project_colors.dart';

import '../main.dart';
import '../model/task_model.dart';

class HomePageController extends GetxController {
  TextEditingController taskTitleController = TextEditingController();

  RxBool isWalletManage = false.obs;

  void changeIsWalletManage(bool value){
    isWalletManage.value = value;
  }

  void clearControllers(){
    taskTitleController.clear();
  }

  void insertPurse(TaskModel model,bool isUpdate) {
    objectBox.insertTask(model);
    clearControllers();
    Get.back();
    isUpdate ? Get.snackbar("updated".tr, "update_success".tr,backgroundColor: ProjectColor.darkBlueColor) : Get.snackbar("added".tr, "added_success".tr,backgroundColor: ProjectColor.greenColor);
  }
  void deletePurse(int id){
    objectBox.deleteTask(id);
    Get.back();
    Get.snackbar("deleted".tr, "deleted_success".tr,backgroundColor: ProjectColor.redColor);
  }
}
