import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:wiliams/Controllers/Customers/customer_controller.dart';
import 'package:wiliams/Models/customer_model.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';
import '../../Utils/routing_utils.dart';
import '../../Utils/shimmer_widget.dart';
import '../../Utils/view_utils.dart';
import '../../Widgets/my_app_bar.dart';
import '../build_background.dart';

class CustomersScreen extends StatelessWidget {
  final MainGetxController appBarController = Get.find<MainGetxController>();
  final CustomerController controller = Get.put(CustomerController());
  final bool mainPage;

  CustomersScreen({
    Key? key,
    this.mainPage = false,
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
    // controller.fetchCustomers("10");
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildBackGround(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Iconsax.user,
                  color: ColorUtils.secondaryColor,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  "مشتریان",
                  style: TextStyle(
                      color: ColorUtils.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: controller.customersIsLoading.isTrue
                  ? customersLoading()
                  : controller.customers.isNotEmpty
                      ? customers()
                      : Container(),
            ),
          ),
          SizedBox(height: Get.height / 12),
        ],
      ),
    );
  }

  Widget filterMenu(String type) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: ColorUtils.primaryColor,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () =>
                {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 8.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.sort,
                    color: ColorUtils.primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customerCard(int index) {
    CustomerModel customer = controller.customers[index];
    return InkWell(
      onTap: () => {

      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 0,
        ),
        decoration: BoxDecoration(
          color: ColorUtils.white,
          border: Border.all(
            color: ColorUtils.gray,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.gray.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 12,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: FadeInImage(
                width: Get.width / 4,
                height: Get.width / 4,
                placeholder: ImageUtils.placeholder,
                image: NetworkImage(
                  customer.image,

                ),

                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        customer.firstName + ' ' + customer.lastName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        'نام فروشگاه: ',
                        style: TextStyle(
                            color: ColorUtils.textBlack, fontSize: 13),
                      ),
                      Text(
                        customer.shop_name + " (" + customer.shop_type + ")",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        'آدرس: ',
                        style: TextStyle(
                            color: ColorUtils.textBlack, fontSize: 13),
                      ),
                      Text(
                        customer.address,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'همراه: ',
                            style: TextStyle(
                                color: ColorUtils.textBlack, fontSize: 13),
                          ),
                          Text(
                            customer.mobile,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 32.0,),
                      Row(
                        children: [
                          Text(
                            'تلفن: ',
                            style: TextStyle(
                                color: ColorUtils.textBlack, fontSize: 13),
                          ),
                          Text(
                            customer.tel,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customerCardLoading(int index) {
    return InkWell(
      child: Container(
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                child: ShimmerWidget(
                  width: Get.width / 4 - 20,
                  height: Get.width / 4,
                )),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const ShimmerWidget(
                        height: 15,
                        width: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const ShimmerWidget(
                        height: 10,
                        width: 30,
                      ),
                      const ShimmerWidget(
                        height: 10,
                        width: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const ShimmerWidget(
                        height: 10,
                        width: 30,
                      ),
                      const ShimmerWidget(
                        height: 10,
                        width: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget customers() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 1,
        mainAxisExtent: 100,
      ),
      itemCount: controller.customers.length,
      itemBuilder: (BuildContext context, int index) {
        return customerCard(index);
      },
    );
  }

  Widget customersLoading() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        mainAxisExtent: 100,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return customerCardLoading(index);
      },
    );
  }
}
