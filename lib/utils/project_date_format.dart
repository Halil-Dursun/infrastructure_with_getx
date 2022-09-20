

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectDateFormat{
  static String dateToString(DateTime date){
    return DateFormat('d MMM yyyy EEEE kk:mm',Get.locale.toString()).format(date);
  }
}