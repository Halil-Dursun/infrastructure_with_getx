import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:local_project/controller/wallet_detail_page_controller.dart';
import 'package:local_project/model/task_wallet_model.dart';
import 'package:local_project/utils/project_colors.dart';
import 'package:local_project/utils/project_date_format.dart';
import 'package:local_project/utils/project_text_style.dart';
import 'package:sizer/sizer.dart';

import '../model/task_model.dart';

// ignore: must_be_immutable
class WalletDetailPage extends StatefulWidget {
  WalletDetailPage({super.key, required this.model});
  TaskModel model;

  @override
  State<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  late WalletDetailPageController walletDetailPageController;

  @override
  void initState() {
    super.initState();
    walletDetailPageController = Get.put(WalletDetailPageController());
    walletDetailPageController.showList.value =
        widget.model.walletItemModelList;
    walletDetailPageController.calculateTotalAmount();
  }

  // void searchList(String? value) {
  //   if (value == null) {
  //     setState(() {
  //       walletDetailPageController.showList.value =
  //           widget.model.walletItemModelList;
  //     });
  //   } else {
  //     setState(() {
  //       walletDetailPageController.showList.value = widget
  //           .model.walletItemModelList
  //           .where((element) =>
  //               element.title.toLowerCase().contains(value.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        floatingActionButton: _floatingActionButton(),
        appBar: AppBar(
          title: Text("wallet_manage".tr),
        ),
        body: Obx(
          () => _body(),
        ),
      ),
    ));
  }

  Widget _body() {
    if (walletDetailPageController.showList.isNotEmpty) {
      return Column(
      children: [
        //SearchBar(onCahnged: searchList, hintText: 'search'.tr),
        Expanded(
          flex: 15,
          child: ListView.builder(
            itemCount: walletDetailPageController.showList.length,
            itemBuilder: (context, index)=> _showListWidget(index),
          ),
        ),
        GetX<WalletDetailPageController>(
          builder: (controller) => Expanded(
            flex: 2,
            child: _walletTotalWidget(controller),
          ),
        ),
      ],
    );
    } else {
      return _showListEmptyWidget();
    }
  }

  Container _showListWidget(int index) {
    return Container(
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          walletDetailPageController.showList[index].isEarn ?  ProjectColor.greenColor.withOpacity(.6):ProjectColor.redColor.withOpacity(.6),
          ProjectColor.whiteColor,
        ]),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              walletDetailPageController.deleteWalletModelToList(
                  widget.model, walletDetailPageController.showList[index]);
              setState(() {});
            },
            backgroundColor: ProjectColor.redColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'delete'.tr,
          ),
          SlidableAction(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            onPressed: (context) {
              addWalletModelBottomSheet(
                  isUpdate: true,
                  taskWalletModel: walletDetailPageController.showList[index]);
              walletDetailPageController.walletAmountController.text =
                  walletDetailPageController.showList[index].amount.toString();
              walletDetailPageController.walletTitleController.text =
                  walletDetailPageController.showList[index].title;
              walletDetailPageController.walletDescriptionController.text =
                  walletDetailPageController.showList[index].description;
              walletDetailPageController.isEarn.value =
                  walletDetailPageController.showList[index].isEarn;
            },
            backgroundColor: ProjectColor.darkBlueColor,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: 'update'.tr,
          ),
        ]),
        child: Container(
          width: Get.width,
          height: Get.height * .2,
          padding: EdgeInsets.all(2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                walletDetailPageController.showList[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ProjectTextStyle.textStyle(
                    fontSize: 15.sp,
                    isBold: true,
                    color: ProjectColor.blackColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                walletDetailPageController.showList[index].description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: ProjectTextStyle.textStyle(
                    fontSize: 11.sp,
                    color: ProjectColor.blackColor),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  ProjectDateFormat.dateToString(
                      walletDetailPageController.showList[index].date),
                  style: ProjectTextStyle.textStyle(
                      fontSize: 12.sp,
                      isBold: true,
                      color: ProjectColor.blueGreyColor),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: AutoSizeText(
                  maxLines: 1,
                  walletDetailPageController.showList[index].isEarn
                      ? ("+${walletDetailPageController.showList[index].amount}")
                      : ("-${walletDetailPageController.showList[index].amount}"),
                  style: ProjectTextStyle.textStyle(
                      fontSize: 22.sp,
                      isBold: true,
                      color:
                          walletDetailPageController.showList[index].isEarn
                              ? ProjectColor.greenColor
                              : ProjectColor.redColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _showListEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            size: 50.sp,
            color: ProjectColor.redColor,
          ),
          const SizedBox(height: 10,),
          Text(
            'wallet_list_no_data'.tr,
            textAlign: TextAlign.center,
            style: ProjectTextStyle.textStyle(
                fontSize: 20.sp,
                isBold: true,
                color: ProjectColor.blueGreyColor),
          ),
        ],
      ),
    );
  }

  Container _walletTotalWidget(WalletDetailPageController controller) {
    return Container(
      color:controller.totalAmount.value >= 0
                      ? ProjectColor.greenColor.withOpacity(.2)
                      : ProjectColor.redColor.withOpacity(.2),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: Get.width,
      child: Row(
        children: [
          Text(
            '${'total'.tr} : ',
            style: ProjectTextStyle.textStyle(
                fontSize: 25.sp,
                color: ProjectColor.blueGreyColor,
                isBold: true),
          ),
          Flexible(
            child: AutoSizeText(
              maxLines: 1,
              controller.totalAmount.value.toString(),
              style: ProjectTextStyle.textStyle(
                  fontSize: 22.sp,
                  color: controller.totalAmount.value >= 0
                      ? ProjectColor.greenColor
                      : ProjectColor.redColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton() {
    return Padding(
      padding: EdgeInsets.only(bottom : 4.60.h),
      child: FloatingActionButton(
        backgroundColor: ProjectColor.greenColor,
        onPressed: () {
          walletDetailPageController.clearControllers();
          addWalletModelBottomSheet(isUpdate: false);
        },
        child: const Icon(
          Icons.add,
          color: ProjectColor.whiteColor,
        ),
      ),
    );
  }

  dynamic addWalletModelBottomSheet(
      {required bool isUpdate, TaskWalletModel? taskWalletModel}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: Get.height * .5,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: ProjectColor.greenColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller:
                            walletDetailPageController.walletTitleController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'title'.tr,
                          hintStyle: ProjectTextStyle.textStyle(
                              fontSize: 10.sp,
                              isBold: false,
                              color: ProjectColor.cyanColor),
                          prefixIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 10.sp,
                            color: ProjectColor.cyanColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: ProjectColor.greenColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        controller: walletDetailPageController
                            .walletDescriptionController,
                        decoration: InputDecoration(
                          hintText: 'description'.tr,
                          hintStyle: ProjectTextStyle.textStyle(
                              fontSize: 10.sp,
                              isBold: false,
                              color: ProjectColor.cyanColor),
                          prefixIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 10.sp,
                            color: ProjectColor.cyanColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: ProjectColor.greenColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller:
                            walletDetailPageController.walletAmountController,
                        decoration: InputDecoration(
                          hintText: 'amount'.tr,
                          hintStyle: ProjectTextStyle.textStyle(
                              fontSize: 10.sp,
                              isBold: false,
                              color: ProjectColor.cyanColor),
                          prefixIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 10.sp,
                            color: ProjectColor.cyanColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(1.w),
                      child: GetX<WalletDetailPageController>(
                        builder: (controller) => Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  walletDetailPageController.changeIsEarn(true);
                                },
                                child: Container(
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    color:
                                        ProjectColor.greenColor.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: controller.isEarn.value ? 2.0 : .5,
                                      color: ProjectColor.cyanColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'earn'.tr,
                                      style: ProjectTextStyle.textStyle(
                                          fontSize: 12.sp,
                                          color: ProjectColor.greenColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: .5.w,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  walletDetailPageController
                                      .changeIsEarn(false);
                                },
                                child: Container(
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    color:
                                        ProjectColor.greenColor.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: controller.isEarn.value ? .5 : 2.0,
                                      color: ProjectColor.cyanColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'loss'.tr,
                                      style: ProjectTextStyle.textStyle(
                                          fontSize: 12.sp,
                                          color: ProjectColor.redColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      height: 7.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isUpdate
                            ? () {
                                if (walletDetailPageController.walletAmountController.text.isNotEmpty) {
                                  walletDetailPageController
                                    .updateWalletModelToList(
                                        widget.model, taskWalletModel!);
                                setState(() {});
                                } else {
                                Get.snackbar('error'.tr, 'amount_empty_error'.tr,backgroundColor: ProjectColor.redColor);
                                }
                              }
                            : () {
                              if(walletDetailPageController.walletAmountController.text.isNotEmpty){
                                walletDetailPageController
                                    .addWalletModelToList(widget.model);
                                setState(() {});
                              }else{
                                Get.snackbar('error'.tr, 'amount_empty_error'.tr,backgroundColor: ProjectColor.redColor);
                              }
                                
                              },
                        style: ElevatedButton.styleFrom(
                          primary: ProjectColor.greenColor,
                        ),
                        child: Text(
                          'save'.tr,
                          style: ProjectTextStyle.textStyle(
                            color: ProjectColor.whiteColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

// ListTile(
//                             title: Text(
//                                 walletDetailPageController
//                                     .showList[index].title,
//                                 style: ProjectTextStyle.textStyle(
//                                     fontSize: 12.sp,
//                                     color: ProjectColor.whiteColor,
//                                     isBold: true)),
//                             subtitle: Text(
//                               walletDetailPageController
//                                   .showList[index].description,
//                               style: ProjectTextStyle.textStyle(
//                                   fontSize: 10.sp,
//                                   color: ProjectColor.whiteColor),
//                             ),
//                             trailing: Text((walletDetailPageController.showList[index].isEarn ? "+" : "-" ) + 
//                               walletDetailPageController
//                                   .showList[index].amount
//                                   .toString(),
//                               style: ProjectTextStyle.textStyle(
//                                   fontSize: 15.sp,
//                                   color: ProjectColor.whiteColor),
//                             ),
//                             //leading: Text(ProjectDateFormat.dateToString(walletDetailPageController.showList[index].date)),
//                           ),
