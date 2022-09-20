import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_project/controller/onboard_controller.dart';
import 'package:local_project/local_storage/get_storage/get_storage.dart';
import 'package:local_project/model/onboard_model.dart';
import 'package:local_project/utils/project_colors.dart';
import 'package:local_project/view/home_page_view.dart';
import 'package:sizer/sizer.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({Key? key}) : super(key: key);
  OnBoardController _onBoardController = Get.put(OnBoardController());

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        floatingActionButton: GetX<OnBoardController>(builder: (controller) => FloatingActionButton(onPressed: (){
          print(controller.pageIndex);
          if (controller.pageIndex.value == 2) {
            Get.off(HomePage());
            ProjectGetStorage().isFirstOpenWrite();
          } else {
          controller.changePage(controller.pageIndex.value + 1);

          }
        },child: controller.pageIndex.value  != 2 ? Icon(Icons.arrow_forward_ios) : Text("Done"),),),
        body: PageView(
          controller: _onBoardController.onboardPageController,
          onPageChanged: (int value) {
            _onBoardController.changePage(value);
            _onBoardController.pageIndex.value = value;
          },
          children: [
            OnBoardDetailScreen(model: _onBoardController.onboardList[0]),
            OnBoardDetailScreen(model: _onBoardController.onboardList[1]),
            OnBoardDetailScreen(model: _onBoardController.onboardList[2]),
          ],
        ),
      ),
    );
  }
}

class OnBoardDetailScreen extends StatelessWidget {
  OnBoardDetailScreen({super.key, required this.model});
  OnBoardModel model;

  @override
  Widget build(BuildContext context) {
    return GetX<OnBoardController>(builder: (_onBoardController) => Stack(alignment: Alignment.center, children: [
      Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: ProjectColor.greenColor,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 75.sp,
            backgroundColor: Colors.red,
          ),
          Text(model.title),
          Text(model.description),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 4.sp,
                  backgroundColor: _onBoardController.pageIndex.value == 0
                      ? ProjectColor.blueGreyColor.withOpacity(.3)
                      : ProjectColor.whiteColor,
                ),
                SizedBox(width: 4.sp),
                CircleAvatar(
                  radius: 4.sp,
                  backgroundColor: _onBoardController.pageIndex.value == 1
                      ? ProjectColor.blueGreyColor.withOpacity(.3)
                      : ProjectColor.whiteColor,
                ),
                SizedBox(
                  width: 4.sp,
                ),
                CircleAvatar(
                  radius: 4.sp,
                  backgroundColor: _onBoardController.pageIndex.value == 2
                      ? ProjectColor.blueGreyColor.withOpacity(.3)
                      : ProjectColor.whiteColor,
                ),
              ],
            ),
          )
        ],
      )
    ],),);
  }
}
