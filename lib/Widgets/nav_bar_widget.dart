import 'package:flutter/material.dart';
import 'package:wiliams/Controllers/Login/login_controller.dart';
import 'package:wiliams/Controllers/Products/product_controller.dart';
import 'package:wiliams/Globals/Globals.dart';
import 'package:wiliams/Models/user_model.dart';
import 'package:wiliams/Utils/color_utils.dart';
import 'package:wiliams/Utils/routing_utils.dart';
import 'package:wiliams/Utils/stacks.dart';
import 'package:wiliams/Utils/view_utils.dart';
import 'package:wiliams/Widgets/my_app_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../Plugins/get/get.dart';

class NavBar extends StatelessWidget {
  final MainGetxController controller = Get.find<MainGetxController>();

  NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder(
            init: controller,
            builder: (context) {
              return Container(
                width: Get.width ,
                height: Get.height / 16,
                decoration: BoxDecoration(
                  // color: ColorUtils.white,

                  boxShadow: [
                    BoxShadow(
                      color: ColorUtils.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 12,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildIcon(
                      index: 0,
                      title: "صفحه اصلی",
                      icon: Iconsax.home_1,
                    ),
                    buildIcon(
                      index: 1,
                      title: "محصولات",
                      icon: Iconsax.tag,
                    ),
                    // buildButton(),
                    buildIcon(
                      index: 2,
                      title: "مشتریان",
                      icon: Iconsax.people,
                    ),

                      // buildIcon(
                      //   index: 3,
                      //   title: "سفارشات",
                      //   icon: Iconsax.activity,
                      // ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget buildIcon({
    required int index,
    required IconData icon,
    required String title,
  }) {
    bool isSelected = index == controller.currentIndex;
    return ClipRRect(
      borderRadius: index == 0
          ? const BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )
          : index == 2
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                )
              : BorderRadius.zero,
      child: Material(
        color: ColorUtils.white,
        child: InkWell(
          onTap: () {
            if (index != controller.currentIndex) {

                controller.currentIndex = index;
                controller.update();

            }
            if (controller.currentIndex == 0){
              Get.delete<LoginController>();
              Get.delete<ProductController>();
            }
          },
          child: Container(
            width: ((Get.width / 1) / 3.6) + 11.2,
            height: Get.height / 16,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected ? ColorUtils.primaryColor : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: isSelected ? ColorUtils.primaryColor : ColorUtils.textGray,
                  size: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? ColorUtils.primaryColor : ColorUtils.textGray,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
