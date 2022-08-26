

import 'package:get/get.dart';
import 'package:local_project/view/home_page_view.dart';
import 'package:local_project/view/settings_page_view.dart';

List<GetPage> getPages = [
  GetPage(name: SettingsPage.settingsPageRoute, page: ()=> const SettingsPage()),
  GetPage(name: HomePage.homePageRoute, page: ()=> const HomePage()),
];