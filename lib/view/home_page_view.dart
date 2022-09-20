import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:local_project/controller/home_page_controller.dart';
import 'package:local_project/main.dart';
import 'package:local_project/model/task_model.dart';
import 'package:local_project/utils/project_colors.dart';
import 'package:local_project/utils/project_date_format.dart';
import 'package:local_project/utils/project_text_style.dart';
import 'package:local_project/view/task_detail_page_redirect.dart';
import 'package:sizer/sizer.dart';

import 'settings_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const homePageRoute = '/view/home_page_view.dart';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;
  late Stream<List<TaskModel>> purseStream;
  late List<TaskModel>? purseList;
  late List<TaskModel> showPurseList;

  @override
  void initState() {
    super.initState();
    homePageController = Get.put<HomePageController>(HomePageController());
    purseStream = objectBox.getPurse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Sizer(
        builder: (context, orientation, deviceType) => Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: ProjectColor.greenColor,
            onPressed: () {
              homePageController.clearControllers();
              showAddTaskDialog(isUpdate: false);
            },
            child: const Icon(
              Icons.add,
              color: ProjectColor.whiteColor,
            ),
          ),
          appBar: AppBar(
            title: Text(
              'home_title'.tr,
              style: ProjectTextStyle.textStyle(
                  fontSize: 20.sp, isBold: true, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(SettingsPage.settingsPageRoute);
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: purseStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                purseList = snapshot.data;
                if (purseList != null && purseList!.isNotEmpty) {
                  showPurseList = purseList!;
                  return ListView.builder(
                    itemCount: showPurseList.length,
                    itemBuilder: (context, index) {
                      final taskModel = showPurseList[index];
                      return SizedBox(
                        width: Get.width,
                        height: Get.height * .12,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: ProjectColor.cyanColor)),
                          child: Slidable(
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) => homePageController
                                        .deletePurse(taskModel.id),
                                    backgroundColor: ProjectColor.redColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'delete'.tr,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      showAddTaskDialog(
                                        isUpdate: true, model: taskModel);
                                      homePageController.taskTitleController.text = showPurseList[index].title;
                                    },
                                    backgroundColor: ProjectColor.darkBlueColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.update,
                                    label: 'update'.tr,
                                  ),
                                ]),
                            child: ListTile(
                              onTap: () => Get.to(() =>
                                  TaskDetailPageRedirect(model: taskModel)),
                              title: Text(
                                taskModel.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: ProjectTextStyle.textStyle(
                                  fontSize: 15.sp,
                                  isBold: true,
                                  color: ProjectColor.cardColor,
                                ),
                              ),
                              subtitle: Text(
                                ProjectDateFormat.dateToString(taskModel.date),
                                style: ProjectTextStyle.textStyle(
                                    fontSize: 12.sp,
                                    color: ProjectColor.blueGreyColor),
                              ),
                              trailing: Icon(
                                taskModel.isPrice
                                    ? Icons.monetization_on_outlined
                                    : Icons.book,
                                size: 25.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber,
                          size: 50.sp,
                          color: Colors.red.shade400,
                        ),
                        Text(
                          "purse_list_no_data".tr,
                          textAlign: TextAlign.center,
                          style: ProjectTextStyle.textStyle(
                            fontSize: 25.sp,
                            isBold: true,
                            color: ProjectColor.blueGreyColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }

  dynamic showAddTaskDialog({required bool isUpdate, TaskModel? model}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          alignment: Alignment.center,
          height: Get.height * 0.3,
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
                    controller: homePageController.taskTitleController,
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
                    )),
              ),
              GetX<HomePageController>(
                builder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.changeIsWalletManage(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        height: 6.h,
                        width: Get.width * .45,
                        decoration: BoxDecoration(
                            color: ProjectColor.greenColor.withOpacity(.2),
                            border: Border.all(
                                width: controller.isWalletManage.value ? .5 : 3,
                                color: ProjectColor.cyanColor)),
                        child: Text(
                          "task_manage".tr,
                          style: ProjectTextStyle.textStyle(
                              fontSize: 12.sp, color: ProjectColor.cyanColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.changeIsWalletManage(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ProjectColor.greenColor.withOpacity(.2),
                            border: Border.all(
                                width: controller.isWalletManage.value ? 3 : 1,
                                color: ProjectColor.cyanColor)),
                        margin: const EdgeInsets.all(5),
                        height: 6.h,
                        width: Get.width * .45,
                        child: Text(
                          "wallet_manage".tr,
                          style: ProjectTextStyle.textStyle(
                              fontSize: 12.sp, color: ProjectColor.cyanColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                height: 7.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isUpdate) {
                      model!.title = homePageController.taskTitleController.text;
                      model.isPrice = homePageController.isWalletManage.value;
                      homePageController.insertPurse(model, true);
                    } else {
                      homePageController.insertPurse(
                          TaskModel(
                              title: homePageController.taskTitleController.text,
                              date: DateTime.now(),
                              isPrice: homePageController.isWalletManage.value
                                  ? true
                                  : false),
                          false);
                    }
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
      ),
    );
  }
}
