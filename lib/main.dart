import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_project/local_storage/get_storage/get_storage.dart';
import 'package:local_project/utils/get_pages.dart';
import 'package:local_project/utils/project_theme.dart';
import 'package:local_project/utils/translation.dart';
import 'view/home_page_view.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("projectStorage");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ProjectGetStorage getStorage = ProjectGetStorage();
    return GetMaterialApp(
      getPages: getPages,
      translations: Messages(),
      locale: getStorage.localeIsTr == null ? Get.deviceLocale : getStorage.localeIsTr! ? const Locale('tr','TR') : const Locale('en','US'),
      fallbackLocale: const Locale('en','UK'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: getStorage.themeIsDark ? ProjectThemes.projectDarkTheme : ProjectThemes.projectLightTheme,
      home: const HomePage(),
    );
  }
}