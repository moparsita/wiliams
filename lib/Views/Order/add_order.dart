import 'dart:io';
import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_radio_buttons/animated_radio_buttons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:wiliams/Models/order_model.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../../Controllers/Order/order_controller.dart';
import '../../Models/product_model.dart';
import '../../Models/temp_image_model.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';
import '../../Utils/view_utils.dart';
import '../../Utils/widget_utils.dart';
import '../../Widgets/form_utils.dart';
import '../../Widgets/my_app_bar.dart';
import '../Customers/add_customer.dart';
import '../build_background.dart';

class AddOrderScreen extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());
  final bool mainPage;

  AddOrderScreen({
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
          ]
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        buildBackGround(
          title: 'ثبت سفارش جدید',
          inner: true,
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: Obx(
            () => controller.ordersIsLoading.isFalse
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customerField(),
                      SizedBox(height: 8.0,),
                      factorTypeField(),
                      SizedBox(height: 8.0,),
                      productList(),
                      priceField(),
                      buttonsWidget(),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  Widget customerField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: FormUtils.select(
            title: "انتخاب مشتری",
            hint: "مشتری مورد نظر خود را انتخاب کنید",
            controller: controller.customerController,
            icon: Iconsax.user,
            errorText: "لطفا مشتری را انتخاب کنید",
            info: 'فاکتور برای مشتری انتخاب شده ثبت خواهد شد',
            onChange: (customer) => print(customer.dropdownId()),
          ),
        ),

        Column(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorUtils.secondaryColor,
                ),
              ),
              child: IconButton(
                  onPressed: () {
                    Get.dialog(AddCustomerScreen());
                    },
                  icon: Icon(
                    Iconsax.user_add,
                    color: ColorUtils.secondaryColor,
                  )),
            ),

            SizedBox(height: 12,),
          ],
        ),
      ],
    );
  }

  Widget factorTypeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text(
            'نوع فاکتور',
            style: TextStyle(
              color: ColorUtils.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Obx(
            () => AnimatedRadioButtons(
              backgroundColor: Colors.transparent,
              value: controller.factorTypeController.value,
              layoutAxis: Axis.horizontal,
              buttonRadius: 30.0,
              items: [
                AnimatedRadioButtonItem(
                  label: "قطعی",
                  color: ColorUtils.primaryColor,
                  fillInColor: ColorUtils.white,
                ),
                AnimatedRadioButtonItem(
                  label: "پیش فاکتور",
                  labelTextStyle: TextStyle(color: Colors.blue),
                  color: ColorUtils.primaryColor,
                  fillInColor: ColorUtils.white,
                ),
              ],
              onChanged: (value) {
                controller.factorTypeController.value = value;
                print(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget factorNumberField() {
    return FormUtils.input(
        title: 'شماره فاکتور',
        hint: '',
        controller: controller.factorNumberController);
  }

  Widget priceField() {
    return WidgetUtils.textField(
        title: 'جمع فاکتور',
        enabled: false,
        heightFactor: 15,
        controller: controller.totalPriceController);
  }

  Widget productList() {
    return SizedBox(
      height: 220,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            controller.products.length,
            (index) => productRow(index),
          ),
        ),
      ),
    );
  }

  Widget productRow(int index) {
    ProductModel product = controller.products[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorUtils.primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: FadeInImage(
                width: Get.width / 6,
                height: Get.width / 6,
                placeholder: ImageUtils.placeholder,
                image: NetworkImage(
                  product.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              children: [
                AutoSizeText(
                  product.name,
                  style: TextStyle(
                    color: ColorUtils.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                AutoSizeText(
                  product.price.seRagham() + ' ریال',
                  style: TextStyle(
                    color: ColorUtils.black,
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  int number =
                      int.tryParse(controller.productController[index].text) ??
                          0;
                  number++;
                  controller.productController[index].text = number.toString();
                  controller.calculateTotalPrice('');
                },
                icon: Icon(Iconsax.add_square,
                    size: 30, color: ColorUtils.primaryColor)),
            SizedBox(
              width: 50,
              child: WidgetUtils.textField(
                title: '0',
                textAlign: TextAlign.center,
                controller: controller.productController[index],
                onChanged: controller.calculateTotalPrice,
              ),
            ),
            IconButton(
                onPressed: () {
                  int number =
                      int.tryParse(controller.productController[index].text) ??
                          0;
                  number--;
                  if (number >= 0) {
                    controller.productController[index].text =
                        number.toString();
                    controller.calculateTotalPrice('');
                  }
                },
                icon: Icon(
                  Iconsax.minus_square,
                  size: 30,
                  color: ColorUtils.secondaryColor,
                )),
          ],
        ),
      ),
    );
  }

  Widget buttonsWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: WidgetUtils.softButton(
        height: 40,
          title: 'ثبت فاکتور',
          onTap: () {
            if (controller.customerController.isSelected.isFalse) {
              ViewUtils.showErrorDialog(
                "لطفا یک مشتری را انتخاب کنید",
              );
            }  else if (controller.totalPriceController.text == '') {
              ViewUtils.showErrorDialog(
                "لطفا محصولی را به سبد خرید اضافه کنید",
              );
            } else {
              Get.dialog(payWidget());
            }
          },
          widthFactor: 1),
    );
  }

  Widget payWidget() {
    return Container(
      height: Get.height * 0.8,
      margin: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: Get.height * 0.05,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.money_2,
                            size: 20,
                            color: ColorUtils.secondaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'پرداخت نقدی',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: ColorUtils.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      WidgetUtils.textField(
                          title: '0',
                          controller: controller.payCashController,
                          onChanged: controller.calculateRemain,
                          keyboardType: TextInputType.number),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.card_pos,
                            size: 20,
                            color: ColorUtils.secondaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'پرداخت با کارتخوان',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: ColorUtils.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      WidgetUtils.textField(
                          title: '0',
                          controller: controller.payPosController,
                          onChanged: controller.calculateRemain,
                          keyboardType: TextInputType.number),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                buildUploaderButton(controller.images[1]),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.card,
                            size: 20,
                            color: ColorUtils.secondaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'پرداخت کارت به کارت',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: ColorUtils.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      WidgetUtils.textField(
                          title: '0',
                          controller: controller.payCardController,
                          onChanged: controller.calculateRemain,
                          keyboardType: TextInputType.number),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                buildUploaderButton(controller.images[2]),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.wallet_check,
                            size: 20,
                            color: ColorUtils.secondaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'پرداخت چک',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: ColorUtils.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      WidgetUtils.textField(
                          title: '0',
                          controller: controller.payChequeController,
                          onChanged: controller.calculateRemain,
                          keyboardType: TextInputType.number),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                buildUploaderButton(controller.images[3]),
              ],
            ),





            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(
                  Iconsax.bank,
                  size: 20,
                  color: ColorUtils.secondaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'مبلغ کل',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: ColorUtils.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            WidgetUtils.textField(
              title: '',
              price: true,
              enabled: false,
              controller: controller.totalPriceController,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(
                  Iconsax.calculator,
                  size: 20,
                  color: ColorUtils.secondaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'مانده سفارش',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: ColorUtils.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            WidgetUtils.textField(
              title: '',
              price: true,
              enabled: false,
              controller: controller.remainController,
            ),
            Spacer(),
            WidgetUtils.softButton(
              height: 40,
                title: 'ثبت نهایی',
                onTap: () {
                  controller.submit();
                },
                widthFactor: 1),
          ],
        ),
      ),
    );
  }
  Widget buildUploaderButton(TempImageModel image) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.gray.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 12,
            ),
          ],
        ),
        child: DottedBorder(
          padding: const EdgeInsets.all(1),
          radius: const Radius.circular(10.0),
          borderType: BorderType.RRect,
          dashPattern: const [10, 10, 10, 10],
          strokeWidth: 1,
          color: ColorUtils.textGray,
          strokeCap: StrokeCap.butt,
          child: Container(
            height: Get.height / 15,
            width: Get.width / 7,
            decoration: BoxDecoration(
              color: ColorUtils.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Obx(
                  () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: image.isLoading.isTrue
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => controller.addImage(image),
                    child: SizedBox(
                      width: Get.width,
                      child: image.path.isEmpty
                          ? Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Iconsax.image,
                            color: ColorUtils.purple,
                            size: 20,
                          ),
                          Text(
                            image.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          File(
                            image.path,
                          ),
                          fit: BoxFit.cover,
                          height: Get.height / 8.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
