import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:local_project/controller/task_detail_page_controller.dart';
import 'package:local_project/model/task_item_model.dart';
import 'package:sizer/sizer.dart';
import '../model/task_model.dart';
import '../utils/project_colors.dart';
import '../utils/project_date_format.dart';
import '../utils/project_text_style.dart';

// ignore: must_be_immutable
class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({super.key, required this.model});
  TaskModel model;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TaskDetailPageController taskDetailPageController;

  @override
  void initState() {
    super.initState();
    taskDetailPageController = Get.put(TaskDetailPageController());
    taskDetailPageController.showList.value = widget.model.taskItemModeList;
  }

  // void searchList(String? value) {
  //   if (value == null) {
  //     setState(() {
  //       taskDetailPageController.showList.value = widget.model.taskItemModeList;
  //     });
  //   } else {
  //     setState(() {
  //       taskDetailPageController.showList.value = widget.model.taskItemModeList
  //           .where((element) =>
  //               element.title.toLowerCase().contains(value.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        floatingActionButton: _floatingActionButton(),
        appBar: AppBar(
          title: Text("task_manage".tr),
        ),
        body: Obx(
          () => _body(),
        ),
      ),
    ));
  }

  Widget _body() {
    if (taskDetailPageController.showList.isNotEmpty) {
      return Column(
        children: [
          //SearchBar(onCahnged: searchList, hintText: 'search'.tr),
          Expanded(
            flex: 15,
            child: ListView.builder(
              itemCount: taskDetailPageController.showList.length,
              itemBuilder: (context, index) => _showListWidget(index),
            ),
          ),
        ],
      );
    } else {
      return _showListEmptyWidget();
    }
  }

  Container _showListWidget(int index) {
    return Container(
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: ProjectColor.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              taskDetailPageController.deleteWalletModelToList(
                  widget.model, taskDetailPageController.showList[index]);
              setState(() {});
            },
            backgroundColor: ProjectColor.redColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'delete'.tr,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            onPressed: (context) {
              addWalletModelBottomSheet(
                  isUpdate: true,
                  taskItemModel: taskDetailPageController.showList[index]);
              taskDetailPageController.taskTitleController.text =
                  taskDetailPageController.showList[index].title;
              taskDetailPageController.taskDescriptionController.text =
                  taskDetailPageController.showList[index].description;
            },
            backgroundColor: ProjectColor.darkBlueColor,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: 'update'.tr,
          ),
        ]),
        child: Container(
          width: Get.width,
          height: Get.height * .2,
          padding: EdgeInsets.all(2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskDetailPageController.showList[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ProjectTextStyle.textStyle(
                    fontSize: 15.sp,
                    isBold: true,
                    color: ProjectColor.blackColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                taskDetailPageController.showList[index].description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: ProjectTextStyle.textStyle(
                    fontSize: 12.sp, color: ProjectColor.blackColor),
              ),
              const Spacer(),
              Row(
                children: [
                  taskDetailPageController.showList[index].isComplate
                      ? Icon(
                          Icons.check,
                          size: 20.sp,
                          color: ProjectColor.greenColor,
                        )
                      : SizedBox(
                        height: 5.h,
                        width: 30.w,
                        child: ElevatedButton(
                          
                          style: ElevatedButton.styleFrom(
                            primary: ProjectColor.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                width: 1,
                                color: ProjectColor.blueColor,
                              )
                            )
                          ),
                            onPressed: () {
                              taskDetailPageController.taskComplated(taskDetailPageController.showList[index], widget.model);
                              setState(() {
                                
                              });
                            }, child: Text('task_complated'.tr,style: ProjectTextStyle.textStyle(
                              color: ProjectColor.blueColor,
                              fontSize: 7.sp,
                            ),),),
                      ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      ProjectDateFormat.dateToString(
                          taskDetailPageController.showList[index].date),
                      style: ProjectTextStyle.textStyle(
                          fontSize: 14.sp,
                          isBold: true,
                          color: ProjectColor.blackColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _showListEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            size: 40.sp,
            color: ProjectColor.redColor,
          ),
          Text(
            "task_list_no_data".tr,
            style: ProjectTextStyle.textStyle(
                fontSize: 20.sp,
                isBold: true,
                color: ProjectColor.blueGreyColor),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: ProjectColor.greenColor,
      onPressed: () {
        taskDetailPageController.clearControllers();
        addWalletModelBottomSheet(isUpdate: false);
      },
      child: const Icon(
        Icons.add,
        color: ProjectColor.whiteColor,
      ),
    );
  }

  dynamic addWalletModelBottomSheet(
      {required bool isUpdate, TaskItemModel? taskItemModel}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                height: Get.height * .3,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: ProjectColor.greenColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller:
                            taskDetailPageController.taskTitleController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'title'.tr,
                          hintStyle: ProjectTextStyle.textStyle(
                              fontSize: 10.sp,
                              isBold: false,
                              color: ProjectColor.cyanColor),
                          prefixIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 10.sp,
                            color: ProjectColor.cyanColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: ProjectColor.greenColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller:
                            taskDetailPageController.taskDescriptionController,
                        decoration: InputDecoration(
                          hintText: 'description'.tr,
                          hintStyle: ProjectTextStyle.textStyle(
                              fontSize: 10.sp,
                              isBold: false,
                              color: ProjectColor.cyanColor),
                          prefixIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 10.sp,
                            color: ProjectColor.cyanColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      height: 7.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isUpdate
                            ? () {
                                taskDetailPageController.updateTaskModelToList(
                                    widget.model, taskItemModel!);
                                setState(() {});
                              }
                            : () {
                                taskDetailPageController
                                    .addWalletModelToList(widget.model);
                                setState(() {});
                              },
                        style: ElevatedButton.styleFrom(
                          primary: ProjectColor.greenColor,
                        ),
                        child: Text(
                          'save'.tr,
                          style: ProjectTextStyle.textStyle(
                            color: ProjectColor.whiteColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
