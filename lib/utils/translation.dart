import 'package:get/get.dart';

class Messages extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US' : {
      'home_title':'Home',
      'search' : 'Search',
      'settings' : 'Settings',
      'language' : 'Language',
      'theme' : 'Theme',
    },
    'tr_TR' : {
      'home_title' : 'Anasayfa',
      'search' : 'Ara',
      'settings' : 'Ayarlar',
      'language' : 'Dil',
      'theme' : 'Tema',
    },
  };

}