import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/project_colors.dart';
import '../utils/project_text_style.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({super.key,this.onCahnged,this.backGroundColor,required this.hintText,this.hintTextStyle,this.prefixIcon});
  void Function(String)? onCahnged;
  Color? backGroundColor;
  String hintText;
  TextStyle? hintTextStyle;
  Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return  Container(
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: backGroundColor ?? ProjectColor.greenColor.withOpacity(.2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: _searchBar(),
  );
  }

  
  TextField _searchBar() {
    return TextField(
      onChanged: onCahnged,
      decoration: InputDecoration(
      hintText: hintText.tr,
      hintStyle: hintTextStyle ?? ProjectTextStyle.textStyle(
          fontSize: 16, isBold: false, color: ProjectColor.cyanColor),
      prefixIcon: prefixIcon ?? const Icon(
        Icons.search_outlined,
        color: ProjectColor.cyanColor,
      ),
      border: InputBorder.none,
    ));
  }
}

