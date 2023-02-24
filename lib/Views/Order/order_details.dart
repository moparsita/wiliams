
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wiliams/Models/factor_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:wiliams/Models/order_model.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../../Controllers/Home/home_controller.dart';
import '../../Controllers/Order/order_controller.dart';
import '../../Plugins/get/get_core/src/get_main.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';
import '../../Utils/view_utils.dart';
import '../../Widgets/my_app_bar.dart';
import '../build_background.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());
  final bool mainPage;
  Widget? factorId;
  OrderDetailsScreen({
    Key? key,
    this.mainPage = false,
    this.factorId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        return true;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
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

      ),
    );
  }
  Widget buildBody() {
     // controller.init();

    return SingleChildScrollView(
      child: Column(
        children: [
          buildBackGround(
            title: 'جزئیات فاکتور',
            inner: true,
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: [
                      Icon(
                        Iconsax.user,
                        color: Colors.red,
                      ),
                      SizedBox(width: 8.0,),

                      Text(
                        "سفارش شماره " + controller.singleFactor.factorId.toString(),
                        style: TextStyle(
                            color: ColorUtils.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      Spacer(),

                    ],

                  ),
                SizedBox(height: 24.0),
                orderBrief(),
                customerData(),
                Products(),

              ],
            ),


          ),

        ],
      ),
    );
  }


  Widget orderBrief() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("اطلاعات سفارش ",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorUtils.primaryColor,

            ),
          textAlign: TextAlign.right,),
          SizedBox(height: 12.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('شناسه سفارش',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.factorId.toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('تاریخ ثبت سفارش',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.date != null ? controller.singleFactor.date.toPersianDate() : '',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('سفارش دهنده',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.customer.shopName + ' (' + controller.singleFactor.customer.firstName + ' ' + controller.singleFactor.customer.lastName + ')',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('جمع سفارش',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.price.seRagham()  + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('پرداخت با کارتخوان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.pos == '' ? 'ندارد' : controller.singleFactor.pos + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('پرداخت کارت به کارت',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.card == ''? 'ندارد' : controller.singleFactor.card + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('پرداخت نقدی',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.cash == '' ? 'ندارد' : controller.singleFactor.cash + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('پرداخت با چک',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.cheque == '' ? 'ندارد' : controller.singleFactor.cheque + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('مانده حساب فاکتور',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.remain == '' ? 'ندارد' : controller.singleFactor.remain + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('تعداد اقلام',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.factorDetails.length.toString() + " قلم",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }
  Widget customerData() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("اطلاعات مشتری ",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorUtils.primaryColor,

            ),
          textAlign: TextAlign.right,),
          SizedBox(height: 12.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('نوع مشتری',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.customer.shopType == 1 ? 'دکه' : 'مغازه',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('نام فروشگاه',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.customer.shopName,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('نام مشتری',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.customer.firstName + ' ' + controller.singleFactor.customer.lastName,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('تلفن همراه',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.customer.mobile,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('آدرس فروشگاه',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.customer.address,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('تلفن فروشگاه',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(controller.singleFactor.customer.tel,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),

          SizedBox(height: 12,),
        ],
      ),
    );
  }



  Widget Products() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("اطلاعات خرید ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorUtils.primaryColor,

            ),
            textAlign: TextAlign.right,),
          SingleChildScrollView(
            child: Container(
              height: Get.height / 4.5,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.singleFactor.factorDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return productCard(index);
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productCard(int index) {
    FactorDetail product = controller.singleFactor.factorDetails[index];
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(height: 12.0,),
          Row(
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              AutoSizeText(
                product.product.productName,
                style: TextStyle(
                  fontSize: 12.0,
                  color: ColorUtils.textBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(product.name,
              //     maxLines: 2,
              //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          SizedBox(height: 12.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('کد محصول',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(product.id.toString(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('قمیت واحد',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(product.price.toString().seRagham() + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('تعداد',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(product.amount.toString() + ' عدد',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Iconsax.activity, size: 15, color: ColorUtils.primaryColor,),
              SizedBox(width: 8.0),
              Text('قمیت کل',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack)),
              SizedBox(width: 8.0),
              Expanded(child: Text('.' * 100, maxLines: 1, style: TextStyle(color: ColorUtils.primaryColor.shade100),)),
              SizedBox(width: 8.0),
              Text(product.totalPrice.toString().seRagham() + ' تومان',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorUtils.textBlack))
            ],
          ),
        ],
      ),
    );
  }
}