import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'Globals/Globals.dart';
import 'Plugins/get/get.dart';
import 'Plugins/refresher/src/smart_refresher.dart';
import 'Utils/color_utils.dart';
import 'Utils/routing_utils.dart';
import 'Views/Splash/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


// const MethodChannel methodChannel = MethodChannel('today.parsa.wiliams/printer');
void main() async {
  // HttpOverrides.global = MyHttpOverrides();

  await GetStorage.init();
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  WidgetsFlutterBinding.ensureInitialized();



  runApp(
    RefreshConfiguration(
      footerTriggerDistance: 10,
      child: StreamBuilder(
        stream: Globals.darkModeStream.getStream,
        builder: (context, snapshot) {
          return GetMaterialApp(
            textDirection: TextDirection.rtl,
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.cupertino,
            theme: ThemeData(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: ColorUtils.primaryColor,
              ),
              disabledColor: ColorUtils.gray,
              tabBarTheme: TabBarTheme(
                labelStyle: TextStyle(
                  color: ColorUtils.black,
                  fontFamily: 'iranSans',
                  fontWeight: FontWeight.bold,
                ),
                labelColor: ColorUtils.black,
                unselectedLabelStyle: TextStyle(
                  color: ColorUtils.black,
                  fontFamily: 'iranSans',
                ),
              ),
              cardColor: ColorUtils.white,
              textTheme: TextTheme(
                subtitle1: TextStyle(
                  color: ColorUtils.black,
                ),
                bodyText1: TextStyle(
                  color: ColorUtils.black,
                ),
                bodyText2: TextStyle(
                  color: ColorUtils.black,
                ),
              ),
              iconTheme: IconThemeData(
                color: ColorUtils.black,
              ),
              fontFamily: 'iranSans',
              canvasColor: ColorUtils.white,
              primaryColor: ColorUtils.primaryColor,
              primarySwatch: ColorUtils.primaryColor,
            ),
            getPages: [
              RoutingUtils.splash,
              RoutingUtils.main,
              RoutingUtils.login,
              RoutingUtils.order,
              RoutingUtils.addOrder,
              RoutingUtils.addUnsuccessfulOrder,
              RoutingUtils.orders,
              RoutingUtils.unsuccessfulOrders,
              RoutingUtils.products,
              RoutingUtils.customers,
              RoutingUtils.profile,
              RoutingUtils.support,
              RoutingUtils.guide,
              RoutingUtils.about,
              RoutingUtils.faq,
            ],
            builder: EasyLoading.init(),
            home: SplashScreen(),
          );
        },
      ),
    ),
  );
}
