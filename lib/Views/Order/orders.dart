import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wiliams/Models/factor_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:wiliams/Models/order_model.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../../Controllers/Order/order_controller.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';
import '../../Utils/routing_utils.dart';
import '../../Utils/shimmer_widget.dart';
import '../../Utils/view_utils.dart';
import '../../Utils/widget_utils.dart';
import '../../Widgets/my_app_bar.dart';
import '../build_background.dart';

class OrdersScreen extends StatelessWidget {
  final MainGetxController appBarController = Get.find<MainGetxController>();
  final OrderController controller = Get.put(OrderController());
  final bool mainPage;

  OrdersScreen({
    Key? key,
    this.mainPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchFactors();
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Stack(
        children: [
          Image.asset(
            "assets/img/bg.png",
            width: Get.width,
            fit: BoxFit.cover,

          ),
          Scaffold(
            body: buildBody(),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    // controller.fetchOrders(controller.perPage.value, controller.status);
    // controller.fetchOrders("10", "");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildBackGround(
          title: 'سوابق فروش',
          inner: true,
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Iconsax.user,
                color: Colors.red,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                "سفارشات",
                style: TextStyle(
                    color: ColorUtils.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const Spacer(),
              // filterMenu("sort"),
              const SizedBox(width: 6.0),
            ],
          ),
        ),
        OrderCards(),
        const SizedBox(height: 64),
      ],
    );
  }


  Widget OrderCards() {
    return Obx(
      () => Expanded(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: controller.ordersIsLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.orders.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildOrder(index);
                      },
                    )
                  : const Center(
                      child: Text(
                        'سفارشی برای نمایش وجود ندارد',
                      ),
                    ),
        ),
      ),
    );
  }

  Widget buildOrder(int index) {
    FactorModel factor = controller.orders[index];
    return Container(
      width: Get.width,
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "سفارش شماره " + factor.factorId.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.primaryColor),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Iconsax.activity,
                  size: 15,
                  color: ColorUtils.primaryColor,
                ),
                const SizedBox(width: 8.0),
                Text('شناسه سفارش',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack)),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                Text(factor.factorId.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack))
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Iconsax.activity,
                  size: 15,
                  color: ColorUtils.primaryColor,
                ),
                const SizedBox(width: 8.0),
                Text('تاریخ ثبت سفارش',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack)),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                Text(
                  factor.date != null ? factor.date : '',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.textBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Iconsax.activity,
                  size: 15,
                  color: ColorUtils.primaryColor,
                ),
                const SizedBox(width: 8.0),
                Text('سفارش دهنده',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack)),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                Text(
                    factor.customer.shopName +
                        ' (' +
                        factor.customer.firstName +
                        ' ' +
                        factor.customer.lastName +
                        ')',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack))
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Iconsax.activity,
                  size: 15,
                  color: ColorUtils.primaryColor,
                ),
                const SizedBox(width: 8.0),
                Text('جمع سفارش',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack)),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                Text(factor.price.seRagham() + 'تومان',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack))
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Iconsax.activity,
                  size: 15,
                  color: ColorUtils.primaryColor,
                ),
                const SizedBox(width: 8.0),
                Text('تعداد اقلام',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack)),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                Text(factor.factorDetails!.length.toString() + " عدد",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.textBlack))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WidgetUtils.softButton(
                  widthFactor: 1.12,
                  title: "مشاهده اطلاعات",
                  icon: Iconsax.search_favorite,
                  reverse: true,
                  iconSize: 15,
                  fontSize: 15,
                  radius: 25,
                  fontWeight: FontWeight.bold,
                  height: 40,
                  onTap: () async {
                    controller.singleFactor = factor;
                    var result =
                        await Get.toNamed(RoutingUtils.order.name, parameters: {
                      'factorId': factor.factorId.toString(),
                    });
                    Get.parameters.clear();
                    if (result == true) {
                      controller.onInit();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoadingOrders() {
    return Container(
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerWidget(
                  height: 10,
                  width: 10,
                ),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  '.' * 100,
                  maxLines: 1,
                  style: TextStyle(color: ColorUtils.primaryColor.shade100),
                )),
                const SizedBox(width: 8.0),
                const ShimmerWidget(
                  height: 10,
                  width: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget orderStatusBadge(String status) {
    String title;
    Color bgColor = ColorUtils.gray;
    switch (status) {
      case 'pending':
        status = "درانتظار پرداخت";
        bgColor = ColorUtils.orange;
        break;
      case 'processing':
        status = "در حال انجام";
        bgColor = ColorUtils.green.shade600;
        break;
      case 'on-hold':
        status = "در انتظار بررسی";
        bgColor = ColorUtils.primaryColor;
        break;
      case 'completed':
        status = "تکمیل شده";
        bgColor = ColorUtils.green;
        break;
      case 'cancelled':
        status = "لغو شده";
        bgColor = ColorUtils.purple;
        break;
      case 'refunded':
        status = "مسترد شده";
        bgColor = ColorUtils.yellow;
        break;
      case 'failed':
        status = "ناموفق";
        bgColor = ColorUtils.primaryColor;
        break;
      case 'checkout-draft':
        status = "پیش نویس";
        bgColor = ColorUtils.gray;
        break;
      default:
        status = "نامشخص";
    }
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
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
          '#' + status,
          style: TextStyle(
              color: ColorUtils.white,
              fontSize: 10.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
