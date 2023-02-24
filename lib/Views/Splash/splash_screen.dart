import 'package:flutter/material.dart';
import 'package:wiliams/Controllers/Splash/splash_controller.dart';
import 'package:wiliams/Plugins/get/get.dart';
import 'package:wiliams/Utils/color_utils.dart';


class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());
   SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/img/icon.png',
                    width: 80,
                  ),
                  SizedBox(height: 16.0),
                  Image.asset(
                    'assets/img/txt.png',
                    height: 25,
                  ),
                  SizedBox(height: 48.0),
                  Text('Ramona Software group'),
                  SizedBox(height: 48.0),
                  CircularProgressIndicator(),
                  Spacer(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
