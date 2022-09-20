// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:local_project/model/task_model.dart';
import 'package:local_project/view/task_detail_page.dart';
import 'package:local_project/view/wallet_detail_page.dart';


class TaskDetailPageRedirect extends StatelessWidget {
  TaskDetailPageRedirect({super.key,required this.model});
  TaskModel model;

  @override
  Widget build(BuildContext context) {
    return model.isPrice ? WalletDetailPage(model: model,) : TaskDetailPage(model: model,);
  }
}



