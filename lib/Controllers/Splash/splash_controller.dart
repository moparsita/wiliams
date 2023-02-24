import 'dart:async';
import 'dart:convert';
import 'package:wiliams/Globals/Globals.dart';
import 'package:wiliams/Models/user_model.dart';
import 'package:wiliams/Utils/Api/project_request_utils.dart';
import 'package:wiliams/Utils/routing_utils.dart';

import 'package:wiliams/Plugins/get/get.dart';

import '../../Models/DbModels/customer_db_model.dart';
import '../../Models/DbModels/product_db_model.dart';

class SplashController extends GetxController {
  final RxBool isLoaded = false.obs;
  final RxString dataStatus = 'در حال برقراری ارتباط با سرور...'.obs;
  final int fetchCounter = 100;
  final RxInt dataLevel = 0.obs;

  void checkLogin() async {

    dataLevel.value = 0;
    String token = "no_token";
    // try {
    //   FirebaseMessaging messaging = FirebaseMessaging.instance;
    //   token = await messaging.getToken() ?? "no_token";
    //   print(token);
    // } catch (e) {
    //   print(e.toString());
    // }
    ApiResult result = await RequestsUtil.instance.auth.check(token);
    if (result.isDone){
      Globals.userStream.changeUser(UserModel.fromJson(result.data['user']));
      dataStatus.value = "کاربر پیدا شد";

      Future.delayed(const Duration(seconds: 3), () async {
        Get.offAndToNamed(
          RoutingUtils.main.name,
        );
      });
    } else {
      dataStatus.value = "کاربر پیدا نشد";
      Future.delayed(const Duration(seconds: 3), () async {
        Get.offAndToNamed(
          RoutingUtils.login.name,
        );
      });
    }

  }
  @override
  void onInit() {
    String token = "no_token";
      checkLogin();
    super.onInit();
  }


}
