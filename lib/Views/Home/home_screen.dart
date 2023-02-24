import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wiliams/Controllers/Splash/splash_controller.dart';
import 'package:wiliams/Plugins/get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../Controllers/Home/home_controller.dart';
import '../../Controllers/Profile/profile_controller.dart';
import '../../Globals/Globals.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';
import '../../Utils/routing_utils.dart';
import '../../Utils/shimmer_widget.dart';
import '../../Utils/storage_utils.dart';
import '../../Utils/view_utils.dart';
import '../../Utils/widget_utils.dart';
import '../../Widgets/get_confirmation_dialog.dart';
import '../../Widgets/my_app_bar.dart';

class HomeScreen extends StatelessWidget {
  final MainGetxController appBarController = Get.find<MainGetxController>();
  final HomeController controller = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ViewUtils.sizedBox(14),
                        buildProfile(),
                        ViewUtils.sizedBox(48),
                        buildBody(),
                        ViewUtils.sizedBox(12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }

  Widget buildProfile() {
    return StreamBuilder(
        stream: Globals.userStream.getStream,
        builder: (context, snapshot) {
          return Container(
            height: Get.height / 4.5,
            width: Get.width,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: ColorUtils.white,
              boxShadow: [
                BoxShadow(
                  color: ColorUtils.gray.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 12,
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Get.height / 5 - 46,
                              width: Get.width / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'فروش امروز:',
                                    style: TextStyle(
                                      color: ColorUtils.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150),
                                    child: controller.isLoading.isTrue
                                        ? Column(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                  width: 30.0,
                                                  height: 10.0,
                                                  child: Center(
                                                    child: ShimmerWidget(
                                                      height: 25,
                                                      width: Get.width / 4,
                                                    ),
                                                  )),
                                            ),
                                            Center(
                                              child: SizedBox(
                                                  width: 30.0,
                                                  height: 10.0,
                                                  child: Center(
                                                    child: ShimmerWidget(
                                                      height: 25,
                                                      width: Get.width / 4,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        )
                                        : Column(
                                          children: [
                                            Text(
                                              controller.todaySale
                                                  .toString().seRagham() + ' فاکتور',
                                              style: TextStyle(
                                                color: ColorUtils.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              controller.todayPrice
                                                  .toString().seRagham() + ' ریال',
                                              style: TextStyle(
                                                color: ColorUtils.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),

                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: Get.height / 5 - 54,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      Globals.userStream.user!.fullName,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      Globals.userStream.user!.personalCode,
                                      style: TextStyle(
                                        color: ColorUtils.black,
                                        letterSpacing: 1.5,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height / 5 - 46,
                              width: Get.width / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'کل فروش:',
                                    style: TextStyle(
                                      color: ColorUtils.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150),
                                    child: controller.isLoading.isTrue
                                        ? Column(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                  width: 30.0,
                                                  height: 10.0,
                                                  child: Center(
                                                    child: ShimmerWidget(
                                                      height: 15,
                                                      width: Get.width / 4,
                                                    ),
                                                  )),
                                            ),
                                            Center(
                                              child: SizedBox(
                                                  width: 30.0,
                                                  height: 10.0,
                                                  child: Center(
                                                    child: ShimmerWidget(
                                                      height: 15,
                                                      width: Get.width / 4,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        )
                                        : Column(
                                          children: [
                                            Text(
                                              controller.allTimeSale
                                                  .toString().seRagham() + ' فاکتور',
                                              style: TextStyle(
                                                color: ColorUtils.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            AutoSizeText(
                                              controller.allTimePrice
                                                  .toString().seRagham() + ' ریال',
                                              style: TextStyle(
                                                color: ColorUtils.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WidgetUtils.outlineButton(
                              widthFactor: 2.3,
                              title: "خروج از حساب کاربری",
                              icon: Iconsax.logout,
                              iconSize: 15,
                              fontSize: 12,
                              radius: 25,
                              fontWeight: FontWeight.bold,
                              height: 30,
                              onTap: () async {
                                bool? exit = await GetConfirmationDialog.show(
                                  text: "آیا مطمئن هستید که از حساب کاربری خود خارج شوید؟",
                                  maxFontSize: 16,
                                );
                                if (exit == true) {
                                  await StorageUtils.removeToken();
                                  Get.offAllNamed(RoutingUtils.login.name);
                                  Globals.userStream.changeUser(null);
                                }
                              },
                            ),

                            WidgetUtils.softButton(
                              widthFactor: 2.3,
                              title: "ویرایش پروفایل",
                              icon: Iconsax.edit,
                              reverse: true,
                              iconSize: 15,
                              fontSize: 12,
                              radius: 25,
                              fontWeight: FontWeight.bold,
                              height: 30,
                              onTap: () =>
                              {
                                controller.printFactor(),
                                // Get.toNamed(
                                //   RoutingUtils.profile.name,
                                // )
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -Get.height / 15,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorUtils.white,
                          width: 5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorUtils.gray.withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 3,
                          ),
                        ],
                        shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Image.network(
                        "${Globals.userStream.user!.avatar}?t=${DateTime.now()}",
                        width: Get.height / 8.5,
                        fit: BoxFit.cover,
                        height: Get.height / 8.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildBody() {
    return Column(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [

          buildCard(
            title: 'ثبت سفارش جدید',
            icon: Iconsax.shop_add,
            width: 1,
            height: 0.18,
            onTap: () => Get.toNamed(
              RoutingUtils.addOrder.name,
            ),
          ),
          buildCard(
            title: 'فروش ناموفق',
            icon: Iconsax.shop_add,
            width: 1,
            height: 0.18,
            onTap: () => Get.toNamed(
              RoutingUtils.addUnsuccessfulOrder.name,
            ),
          ),
          buildCard(
            title: 'سوابق فروش',
            icon: Iconsax.shop_add,
            width: 1,
            height: 0.18,
            onTap: () => Get.toNamed(
              RoutingUtils.orders.name,
            ),
          ),
          buildCard(
            title: 'سوابق فروش ناموفق',
            icon: Iconsax.shop_add,
            width: 1,
            height: 0.18,
            onTap: () => Get.toNamed(
              RoutingUtils.unsuccessfulOrders.name,
            ),
          ),

          // TopSellerCard(),
        ]),
      ],
    );
  }

  Widget buildCard({
    void Function()? onTap,
    double width = 0.45,
    double height = 0.45,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * width,
        height: Get.width * height,
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: ColorUtils.white,
          boxShadow: [
            BoxShadow(
              color: ColorUtils.gray.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 12,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: ColorUtils.secondaryColor,
              size: 30,
            ),
            Text(
              title,
              style: TextStyle(
                  color: ColorUtils.textBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard2({
    void Function()? onTap,
    double width = 0.45,
    double height = 0.45,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return InkWell(
      child: Container(
        width: Get.width * width,
        height: Get.width * height,
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: ColorUtils.white,
          boxShadow: [
            BoxShadow(
              color: ColorUtils.gray.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 12,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
          // image: DecorationImage(
          //   image: AssetImage('assets/img/pattern.svg'),
          //   fit: BoxFit.cover
          // )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: ColorUtils.primaryColor,
              size: 25,
            ),
            Text(
              title,
              style: TextStyle(
                  color: ColorUtils.textBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: controller.isLoading.isTrue
                  ? Center(
                      child: SizedBox(
                          width: 30.0,
                          height: 10.0,
                          child: Center(
                            child: ShimmerWidget(
                              height: 25,
                              width: Get.width / 4,
                            ),
                          )),
                    )
                  : Text(
                      subtitle,
                      style: TextStyle(
                          color: ColorUtils.primaryColor.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }



  buildBackGround() {
    return Container(
      height: Get.height / 6,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageUtils.banner,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
          ),
          child: Column(
            children: [
              buildAppBar(),
              ViewUtils.sizedBox(56),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return MyAppBar();
  }




}
