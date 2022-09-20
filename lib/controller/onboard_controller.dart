

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_project/model/onboard_model.dart';

class OnBoardController extends GetxController{
  PageController onboardPageController = PageController();
  RxInt pageIndex = 0.obs;
  List<OnBoardModel> onboardList = [
    OnBoardModel(imagePath: "", title: "title1", description: "description1"),
    OnBoardModel(imagePath: "", title: "title2", description: "description2"),
    OnBoardModel(imagePath: "", title: "title3", description: "description3"),
  ];

  void changePage(int index){
      onboardPageController.jumpToPage(index);
  }
}