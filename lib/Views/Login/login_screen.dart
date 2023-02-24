import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wiliams/Controllers/Login/login_controller.dart';
import 'package:wiliams/Plugins/get/get.dart';
import 'package:wiliams/Utils/color_utils.dart';
import 'package:wiliams/Utils/view_utils.dart';
import 'package:wiliams/Utils/widget_utils.dart';
import 'package:wiliams/Widgets/Components/bezier_container.dart';
import 'package:wiliams/Widgets/Components/circles.dart';
import 'package:wiliams/Widgets/my_app_bar.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(
    LoginController(),
  );

  LoginScreen({Key? key}) : super(key: key);

  List backGroundItems() {
    return [
      Positioned(
        right: Get.width / 1.4,
        top: Get.height / 2,
        child: Transform.rotate(
          angle: 3,
          child: BezierContainer(
            color: ColorUtils.primaryColor.shade800,
          ),
        ),
      ),
      Positioned(
        top: Get.height / 1.4,
        left: Get.width / 2,
        child: Transform.rotate(
          angle: 8,
          child: BezierContainer(
            color: ColorUtils.white.shade50,
          ),
        ),
      ),
      Positioned(
        right: Get.width / 0.85,
        top: Get.height / 6,
        child: CustomPaint(
          painter: CircleOne(
            ColorUtils.white.withOpacity(0.5),
          ),
        ),
      ),
      Positioned(
        right: Get.width / 1.2,
        top: Get.height / 4.5,
        child: CustomPaint(
          painter: CircleTwo(
            ColorUtils.primaryColor.withOpacity(0.5),
          ),
        ),
      ),
      Positioned(
        left: Get.width / 1,
        top: Get.height / 1.2,
        child: CustomPaint(
          painter: CircleTwo(
            ColorUtils.primaryColor.withOpacity(0.5),
          ),
        ),
      ),
      Positioned(
        left: Get.width / 0.95,
        top: Get.height / 4,
        child: CustomPaint(
          painter: CircleOne(
            ColorUtils.primaryColor.withOpacity(
              0.2,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            backgroundColor: ColorUtils.white,
          ),
          ...backGroundItems(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: buildBody(),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ViewUtils.sizedBox(8),
          Image.asset(
            'assets/img/logo.png',
            width: Get.width * 0.6,
            fit: BoxFit.fill,
          ),
          ViewUtils.sizedBox(6),
          AutoSizeText(
            "ورود",
            style: TextStyle(
              fontSize: 21.0,
              color: ColorUtils.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ViewUtils.sizedBox(48),
          mobileInput(),
          SizedBox(
            height: Get.height / 64,
          ),
          passwordInput(),
          SizedBox(
            height: Get.height / 36,
          ),
          button(),

        ],
      ),
    );
  }

  Widget mobileInput() {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: WidgetUtils.textField(
                heightFactor: 15,
                focusNode: controller.mobileFocusNode,
                controller: controller.mobileController,
                onChanged: controller.onChange,
                textAlign: TextAlign.center,
                letterSpacing: 1.5,
                formatter: [
                  LengthLimitingTextInputFormatter(11),
                ],
                keyboardType: TextInputType.phone,
                title: "شماره موبایل",
              ),

    );
  }

  Widget passwordInput() {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
    child: WidgetUtils.textField(
      heightFactor: 15,
      focusNode: controller.passwordNode,
      controller: controller.passwordController,
      letterSpacing: 0,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.visiblePassword,
      title: "رمز عبور",
    ),
    );
  }

  Widget codeInput() {
    return WidgetUtils.textField(
      focusNode: controller.passwordNode,
      controller: controller.passwordController,
      letterSpacing: 0,
      textAlign: TextAlign.center,
      formatter: [
        LengthLimitingTextInputFormatter(4),
      ],
      onChanged: (String string) {
        if (string.length > 3) {
          controller.submit();
        }
      },
      keyboardType: TextInputType.number,
      title: "کد تایید",
    );
  }

  Widget button() {
    return WidgetUtils.softButton(
      height: 35,
      enabled: controller.mobileController.value.text.length == 11,
      title:  "ورود" ,
      onTap: () => controller.submit(),
    );
  }
}
