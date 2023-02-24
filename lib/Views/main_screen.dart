import 'package:flutter/material.dart';
import 'package:wiliams/Controllers/Login/login_controller.dart';
import 'package:wiliams/Globals/Globals.dart';
import 'package:wiliams/Models/user_model.dart';
import 'package:wiliams/Utils/color_utils.dart';
import 'package:wiliams/Widgets/my_drawer.dart';
import 'package:wiliams/Widgets/nav_bar_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wiliams/Widgets/product_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Plugins/get/get.dart';
import '../Widgets/my_app_bar.dart';
import 'Customers/customers.dart';
import 'Order/orders.dart';
import 'Products/products.dart';
import 'Home/home_screen.dart';

class MainScreen extends StatelessWidget {
  final MainGetxController mainController = Get.put(MainGetxController());

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (mainController.currentIndex != 0) {
          mainController.currentIndex = 0;
          Get.delete<LoginController>();
          mainController.update();
          return false;
        }
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          // floatingActionButton: GestureDetector(
          //   onTap: () => {},
          //
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: Get.height / 32),
          //     width: ((Get.width / 1.1) / 5) - 32,
          //     height: ((Get.width / 1.1) / 5) - 32,
          //     decoration: BoxDecoration(
          //       color: ColorUtils.primaryColor,
          //       gradient: LinearGradient(
          //         begin: const Alignment(-1.0, -4.0),
          //         end: const Alignment(1.0, 4.0),
          //         colors: [
          //           ColorUtils.primaryColor,
          //           ColorUtils.primaryColor.shade600,
          //         ],
          //       ),
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //         BoxShadow(
          //           color: ColorUtils.primaryColor.shade700.withOpacity(0.7),
          //           offset: const Offset(1.0, 1.0),
          //           blurRadius: 6.0,
          //           spreadRadius: 1.0,
          //         ),
          //         BoxShadow(
          //           color: ColorUtils.primaryColor.withOpacity(0.2),
          //           offset: const Offset(-2.0, -2.0),
          //           blurRadius: 6.0,
          //           spreadRadius: 1.0,
          //         ),
          //       ],
          //     ),
          //     child: Icon(
          //       Iconsax.shop_add,
          //       size: 20,
          //       color: ColorUtils.white,
          //     ),
          //   ),
          // ),
          resizeToAvoidBottomInset: false,
          key: mainController.scaffoldKey,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              buildPageView(),
              InkWell(
                onTap: (){
                  launchUrl(Uri.parse('https://romina.com'));
                },
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Powered by'),
                        SizedBox(width: 8,),
                        Image.asset(
                          'assets/img/txt.png',
                          fit: BoxFit.scaleDown,
                          height: 20,),
                      ],
                    ),
                  ),
                ),
              ),

              // NavBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageView() {
    return GetBuilder(
      init: mainController,
      builder: (MainGetxController controller) {
      switch (mainController.currentIndex) {
        case 0:
          return HomeScreen();
        case 1:
          return ProductsScreen();
        case 2:
          return CustomersScreen();
        case 3:
          return OrdersScreen();
      }
        return const Scaffold();
      },
    );
  }
}
