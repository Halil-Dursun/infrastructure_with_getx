import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../utils/project_colors.dart';
import '../utils/project_text_style.dart';

class ProjectTextField extends StatelessWidget {
  const ProjectTextField(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Container(
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: ProjectColor.greenColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
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
            )),
      ),
    );
  }
}
