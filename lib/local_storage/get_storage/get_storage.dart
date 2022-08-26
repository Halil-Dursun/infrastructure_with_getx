

import 'package:get_storage/get_storage.dart';

class ProjectGetStorage{
  final box = GetStorage("projectStorage");

  Future<void> localizationWriteToBox(bool isTr) async{
    await box.write("localization", isTr);
  }

  bool? get localeIsTr => box.read("localization");

  Future<void> themeWriteToBox(bool isDark) async{
    await box.write("theme", isDark);
  }

  bool get themeIsDark => box.read("theme") ?? false;
}