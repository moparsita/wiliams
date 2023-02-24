import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:wiliams/Globals/Globals.dart';
import 'package:wiliams/Models/invite_model.dart';
import 'package:wiliams/Plugins/bottomNavBar/persistent-tab-view.dart';
import 'package:wiliams/Plugins/drawer/config.dart';
import 'package:wiliams/Plugins/drawer/flutter_zoom_drawer.dart';
import 'package:wiliams/Plugins/get/get.dart';
import 'package:wiliams/Utils/color_utils.dart';
import 'package:wiliams/Utils/image_utils.dart';
import 'package:wiliams/Utils/routing_utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:location/location.dart';

import '../Models/DbModels/data_db_model.dart';
import '../Models/data_model.dart';
import '../Utils/Api/project_request_utils.dart';
import 'get_confirmation_dialog.dart';

class MainGetxController extends GetxController {
  final RxString mobile = "".obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool isPackageLoaded = false.obs;
  final RxBool dataIsLoading = false.obs;
  PersistentTabController tabviewController = PersistentTabController();
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  late InviteModel inviteModel;
  DataModel? DrawerData;
  Future<void> share() async {

    await FlutterShare.share(
        title: inviteModel.title,
        text: inviteModel.text,
        linkUrl: inviteModel.link,
        chooserTitle: inviteModel.chooser);
  }

  int currentIndex = 0;

  void openDrawer() {
    // Scaffold.of(context).openDrawer();

    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    // Scaffold.of(context).openEndDrawer();
    scaffoldKey.currentState?.openEndDrawer();
  }

  void toggleDrawer() {

    if (scaffoldKey.currentContext?.drawerState == DrawerState.open) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }
  String myLatitude = '';
  String myLongitude = '';
  String myLocation = '';
  LocationData? currentLocation;
  Future<void> getCurrentLocation() async {
    var location = Location();
    try {
      currentLocation = await location.getLocation();
      myLatitude = currentLocation!.latitude.toString();
      myLongitude = currentLocation!.longitude.toString();
      myLocation = myLatitude + ',' + myLongitude;
      ApiResult result =
      await RequestsUtil.instance.data.sendLocation(Location: myLocation);
      print(myLocation);
    } on Exception {
      bool? exit = await GetConfirmationDialog.show(
        text: "در صورت عدم اجازه به لوکیشن از برنامه خارج می شوید",
        maxFontSize: 16,
      );
      if (exit == true) {
        SystemNavigator.pop();
      } else {
        getCurrentLocation();
      }
      myLocation = '';
    }
  }



  @override
  Future<void> onInit() async {
    await getCurrentLocation();
    Timer.periodic(Duration(minutes: 3), (timer) async {
      await getCurrentLocation();
    });
    ApiResult result = await RequestsUtil.instance.data.invite();
    if(result.isDone) {
      inviteModel = InviteModel.fromJson(result.data);
    }

    // fetchDrawerData();
    super.onInit();
  }



  void setScaffoldKey(GlobalKey<ScaffoldState> globalKey) {
    scaffoldKey = globalKey;
  }



}

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget {
  final MainGetxController controller = Get.find();
  final bool inner;
  final bool hasBack;
  final String title;
  Color bgColor = Colors.transparent;

  MyAppBar({
    Key? key,
    this.title = "تنظیمات",
    this.inner = false,
    this.hasBack = false,
    this.bgColor = Colors.transparent,
    GlobalKey<ScaffoldState>? globalKey,
  }) {
    print(globalKey);
    if (globalKey != null) {
      controller.setScaffoldKey(globalKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Globals.userStream.getStream,
        builder: (context, snapshot) {
          return !inner ? buildMainAppBar() : buildSingleAppBar();
        });
  }

  Widget buildMainAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () => Globals.toggleDarkMode(),
          child: Icon(
            Globals.darkModeStream.darkMode ? Iconsax.moon : Iconsax.moon5,
            size: 26,
            color: ColorUtils.white,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Image.asset(
          ImageUtils.logo,
          width: 100,
          height: 100,
        ),

      ],

    );
  }

  Widget buildSingleAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Image.asset(
          ImageUtils.logo,
          width: 100,
          height: 100,
        ),
      ],
      title: Text(
        title,
        style: TextStyle(
          color: ColorUtils.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leadingWidth: 50,
      leading: BackButton(color: ColorUtils.white,),
    );
  }
}
