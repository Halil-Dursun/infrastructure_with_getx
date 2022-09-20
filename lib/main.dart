import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:local_project/local_storage/get_storage/get_storage.dart';
import 'package:local_project/local_storage/objectbox_store/objectbox_store.dart';
import 'package:local_project/utils/get_pages.dart';
import 'package:local_project/utils/project_theme.dart';
import 'package:local_project/utils/translation.dart';
import 'package:local_project/view/onboard_screen.dart';
import 'view/home_page_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


late final ObjectBoxStore objectBox;

Future<void> main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init("projectStorage");
  objectBox = await ObjectBoxStore.init();
  splashInitilization();
  runApp(const MyApp());
}

Future splashInitilization() async{
  await Future.delayed(Duration(seconds:2),(){
    FlutterNativeSplash.remove();
  });
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ProjectGetStorage getStorage = ProjectGetStorage();
    initializeDateFormatting(getStorage.localeIsTr == null ? "en_US" : getStorage.localeIsTr! ? "tr_TR" : "en_US");
    return GetMaterialApp(
      getPages: getPages,
      translations: Messages(),
      locale: getStorage.localeIsTr == null ? Get.deviceLocale : getStorage.localeIsTr! ? const Locale('tr','TR') : const Locale('en','US'),
      fallbackLocale: const Locale('en','US'),
      debugShowCheckedModeBanner: false,
      title: 'Manage Task&Wallet',
      theme: getStorage.themeIsDark ? ProjectThemes.projectDarkTheme : ProjectThemes.projectLightTheme,
      home:  getStorage.isFirstOpen ? OnBoardScreen() : HomePage(),
    );
  }
}