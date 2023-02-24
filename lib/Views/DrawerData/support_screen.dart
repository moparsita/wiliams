

import 'dart:ui';

import 'package:iconsax/iconsax.dart';
import 'package:wiliams/Controllers/Home/home_controller.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../../Plugins/get/get_core/src/get_main.dart';
import '../../Plugins/neu/flutter_neumorphic.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';
import '../../Utils/view_utils.dart';
import '../../Widgets/my_app_bar.dart';

class SupportScreen extends StatelessWidget {
  final MainGetxController controller = Get.put(MainGetxController());
  final bool mainPage;
  Widget? orderId;

  SupportScreen({
    Key? key,
    this.mainPage = false,
    this.orderId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: buildBody(),
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorUtils.white,
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        buildBackGround(),
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
                () =>  controller.dataIsLoading.isFalse ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: ColorUtils.white,
                    border: Border.all(
                      color: ColorUtils.gray,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorUtils.gray,
                        spreadRadius: 5,
                        blurRadius: 12,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                    // image: DecorationImage(
                    //   image: AssetImage('assets/img/pattern.svg'),
                    //   fit: BoxFit.cover
                    // )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.DrawerData!.support.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorUtils.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: Container(
                    width: Get.width,
                    height: Get.height - 260,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      border: Border.all(
                        color: ColorUtils.gray,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.gray,
                          spreadRadius: 5,
                          blurRadius: 12,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/img/pattern.svg'),
                      //   fit: BoxFit.cover
                      // )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        controller.DrawerData!.support.detail,
                        maxLines: 15,
                        style: TextStyle(
                            color: ColorUtils.textBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,

                        ),
                      ),
                    ),
                  ),
                ),

              ],
            )
                :
            Center(child: CircularProgressIndicator()),
          ),

        ),

      ],
    );
  }
  Widget buildBackGround() {
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
    return MyAppBar(
      title: 'پشتیبانی',
      inner: true,
    );
  }



}