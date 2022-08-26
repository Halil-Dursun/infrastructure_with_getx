import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_project/controller/home_page_controller.dart';
import 'package:local_project/model/movie_model.dart';
import 'package:local_project/utils/project_colors.dart';
import 'package:local_project/utils/project_text_style.dart';
import 'package:sizer/sizer.dart';

import 'settings_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const homePageRoute = '/view/home_page_view.dart';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;
  late List<MovieModel> showMovieList;
  @override
  void initState() {
    super.initState();
    homePageController = Get.put<HomePageController>(HomePageController());
    showMovieList = homePageController.movieModelList;
  }

  void searchList(String? value) {
    if (value == null) {
      setState(() {
        showMovieList = homePageController.movieModelList;
      });
    } else {
      setState(() {
        showMovieList = homePageController.movieModelList
            .where((element) =>
                element.movieName.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Sizer(
        builder: (context, orientation, deviceType) => Scaffold(
          appBar: AppBar(
            title: Text(
              'home_title'.tr,
              style: ProjectTextStyle.textStyle(
                  fontSize: 20.sp, isBold: true, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(SettingsPage.settingsPageRoute);
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: ProjectColor.greenColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _searchBar(),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: showMovieList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: ProjectColor.whiteColor,
                        child: ListTile(
                          leading: Image.network(
                            showMovieList[index].imgUrl,
                            errorBuilder: (context, error, stackTrace) =>
                                const CircularProgressIndicator(),
                          ),
                          title: Text(
                            showMovieList[index].movieName,
                            style: ProjectTextStyle.textStyle(
                                fontSize: 14.sp,
                                isBold: true,
                                color: ProjectColor.blackColor),
                          ),
                          subtitle: Text(
                            showMovieList[index].date,
                            style: ProjectTextStyle.textStyle(
                                fontSize: 12.sp,
                                isBold: false,
                                color: ProjectColor.blueGreyColor),
                          ),
                          trailing: Text(
                            showMovieList[index].rating.toString(),
                            style: ProjectTextStyle.textStyle(
                                fontSize: 16.sp,
                                isBold: true,
                                color: Colors.amber),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _searchBar() {
    return TextField(
        onChanged: searchList,
        decoration: InputDecoration(
          hintText: 'search'.tr,
          hintStyle: ProjectTextStyle.textStyle(
              fontSize: 10.sp, isBold: false, color: ProjectColor.cyanColor),
          prefixIcon: const Icon(
            Icons.search_outlined,
            color: ProjectColor.cyanColor,
          ),
          border: InputBorder.none,
        ));
  }
}
