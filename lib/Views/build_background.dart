import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../Utils/color_utils.dart';
import '../Widgets/my_app_bar.dart';

class buildBackGround extends StatelessWidget {
  final String title;
  final bool inner;
  buildBackGround({
    Key? key,
    this.title = "",
    this.inner = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 7,
      width: Get.width,

      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.primaryColor,
          ),
          child: Column(
            children: [
              buildAppBar(),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildAppBar() {
    return MyAppBar(
      title: this.title,
      inner: this.inner,
    );
  }
}