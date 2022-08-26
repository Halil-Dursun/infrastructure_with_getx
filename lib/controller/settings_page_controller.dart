

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../local_storage/get_storage/get_storage.dart';
import '../utils/project_theme.dart';

class SettingsController extends GetxController{
  ProjectGetStorage projectGetStorage = ProjectGetStorage();

  RxBool isDark = (!Get.isDarkMode).obs;

    void changeIsDark(){
    isDark.value = Get.isDarkMode;
  }

    void changeLocal() async {
    await Get.updateLocale(Get.locale == const Locale('tr', 'TR')
        ? const Locale('en', 'US')
        : const Locale('tr', 'TR'));
    if (Get.locale == const Locale('tr', 'TR')) {
      projectGetStorage.localizationWriteToBox(true);
    } else {
      projectGetStorage.localizationWriteToBox(false);
    }
  }

  void changeTheme() {
    Get.changeTheme(Get.isDarkMode
        ? ProjectThemes.projectLightTheme
        : ProjectThemes.projectDarkTheme);
    projectGetStorage.themeWriteToBox(Get.isDarkMode ? false : true);
    changeIsDark();
  }

}