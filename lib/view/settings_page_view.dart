import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_project/controller/settings_page_controller.dart';
import 'package:local_project/utils/project_colors.dart';
import 'package:local_project/utils/project_text_style.dart';
import 'package:sizer/sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String settingsPageRoute = '/view/settings_page_view.dart';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsController settingsController;

  @override
  void initState() {
    super.initState();
    settingsController = Get.put(SettingsController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Sizer(
        builder: (context, orientation, deviceType) => Scaffold(
          appBar: AppBar(
            title: Text('settings'.tr,
                style: ProjectTextStyle.textStyle(
                    fontSize: 20.sp,
                    isBold: true,
                    color: ProjectColor.whiteColor)),
          ),
          body: Center(
            child: Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: const  BoxDecoration(
                      gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ProjectColor.cyanColor,
                    ProjectColor.greenColor,
                  ])),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    height: Get.height * .4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ProjectColor.blueGreyColor.withOpacity(.3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'language'.tr,
                              style: ProjectTextStyle.textStyle(
                                  fontSize: 25.sp,
                                  isBold: true,
                                  color: ProjectColor.blackColor),
                            ),
                            IconButton(
                              onPressed: settingsController.changeLocal,
                              icon: Icon(
                                Icons.language_outlined,
                                size: 25.sp,
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Column(
                            children: [
                              Text(
                                'theme'.tr,
                                style: ProjectTextStyle.textStyle(
                                    fontSize: 25.sp,
                                    isBold: true,
                                    color: ProjectColor.blackColor),
                              ),
                              IconButton(
                                onPressed: settingsController.changeTheme,
                                icon: Icon(
                                    size: 25.sp,
                                    settingsController.isDark.value
                                        ? Icons.dark_mode_outlined
                                        : Icons.light_mode),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
