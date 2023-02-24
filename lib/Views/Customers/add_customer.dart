import 'dart:io';

import 'package:animated_radio_buttons/animated_radio_buttons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wiliams/Controllers/Customers/customer_controller.dart';
import 'package:wiliams/Models/temp_image_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../Globals/Globals.dart';
import '../../Plugins/get/get.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/widget_utils.dart';
import '../../Widgets/form_utils.dart';

class AddCustomerScreen extends StatelessWidget {
  final CustomerController controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
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
          child: Obx(
            () => controller.customerIsLoading.isFalse
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.user_add,
                              color: ColorUtils.secondaryColor,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "افزودن مشتری",
                              style: TextStyle(
                                  color: ColorUtils.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      WidgetUtils.textField(
                        controller: controller.firstNameController,
                        letterSpacing: 0,
                        textAlign: TextAlign.center,
                        title: "نام",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      WidgetUtils.textField(
                        controller: controller.lastNameController,
                        letterSpacing: 0,
                        textAlign: TextAlign.center,
                        title: "نام خانوادگی",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      WidgetUtils.textField(
                        controller: controller.shopNameController,
                        letterSpacing: 0,
                        textAlign: TextAlign.center,
                        title: "نام فروشگاه",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      WidgetUtils.textField(
                        controller: controller.mobileController,
                        letterSpacing: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        title: "شماره همراه",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      WidgetUtils.textField(
                        controller: controller.telController,
                        letterSpacing: 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        title: "تلفن فروشگاه",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      WidgetUtils.textField(
                        controller: controller.addressController,
                        letterSpacing: 0,
                        textAlign: TextAlign.center,
                        title: "آدرس فروشگاه",
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          height: 50,
                          child: Obx(
                              () => AnimatedRadioButtons(
                                backgroundColor: Colors.transparent,
                                value: controller.shopTypeController.value,
                                layoutAxis: Axis.horizontal,
                                buttonRadius: 30.0,
                                items: [
                                  AnimatedRadioButtonItem(
                                    label: "دکه",
                                    color: ColorUtils.primaryColor,
                                    fillInColor: ColorUtils.white,
                                  ),
                                  AnimatedRadioButtonItem(
                                    label: "مغازه",
                                    labelTextStyle:
                                    TextStyle(color: Colors.blue),
                                    color: ColorUtils.primaryColor,
                                    fillInColor: ColorUtils.white,
                                  ),
                                  AnimatedRadioButtonItem(
                                    label: "عمده فروشی",
                                    labelTextStyle:
                                    TextStyle(color: Colors.blue),
                                    color: ColorUtils.primaryColor,
                                    fillInColor: ColorUtils.white,
                                  ),
                                ],
                                onChanged: (value) {
                                  controller.shopTypeController.value = value;
                                  print(value);
                                },
                              ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.images
                            .map((e) => buildUploaderButton(e))
                            .toList(),
                      ),
                      Spacer(),
                      WidgetUtils.softButton(
                          title: 'ثبت مشتری',
                          onTap: () {
                            if (controller
                                    .firstNameController.text.isNotEmpty &&
                                controller.lastNameController.text.isNotEmpty &&
                                controller.shopNameController.text.isNotEmpty &&
                                controller.shopTypeController > 0 &&
                                controller.mobileController.text.isNotEmpty &&
                                controller.telController.text.isNotEmpty &&
                                controller.addressController.text.isNotEmpty) {
                              controller.submit();
                            }
                          },
                          widthFactor: 1.5),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
          ),
        ));
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
            height: Get.height / 9.5,
            width: Get.width / 4.5,
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
                                        size: 30,
                                      ),
                                      Text(
                                        image.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorUtils.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
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
