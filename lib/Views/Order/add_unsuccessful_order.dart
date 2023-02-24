import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_radio_buttons/animated_radio_buttons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wiliams/Controllers/Order/unsuccess_order_controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:wiliams/Models/order_model.dart';
import 'package:wiliams/Plugins/get/get.dart';

import '../../Controllers/Order/order_controller.dart';
import '../../Models/product_model.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';
import '../../Utils/view_utils.dart';
import '../../Utils/widget_utils.dart';
import '../../Widgets/form_utils.dart';
import '../../Widgets/my_app_bar.dart';
import '../Customers/add_customer.dart';
import '../build_background.dart';

class AddUnsuccessfulOrderScreen extends StatelessWidget {
  final UnsuccessfulOrderController controller = Get.put(UnsuccessfulOrderController());
  final bool mainPage;

  AddUnsuccessfulOrderScreen({
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
          ],
        ),

      ),
    );
  }

  Widget buildBody() {
    print(controller.ordersIsLoading.value);
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBackGround(
            title: 'ثبت سفارش ناموفق',
            inner: true,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => controller.ordersIsLoading.isFalse
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customerField(),
                        factorDescriptionField(),
                        buttonsWidget(),
                      ],
                    )
                  : CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget customerField() {
    return FormUtils.select(
      title: "انتخاب مشتری",
      hint: "مشتری مورد نظر خود را انتخاب کنید",
      controller: controller.customerController,
      icon: Iconsax.user,
      errorText: "لطفا مشتری را انتخاب کنید",
      info: 'فاکتور برای مشتری انتخاب شده ثبت خواهد شد',
      onChange: (customer) => print(customer.dropdownId()),
    );
  }


  Widget factorDescriptionField() {
    return FormUtils.textArea(
        title: 'دلیل عدم خرید',
        hint: '',
        controller: controller.factorDescriptionController);
  }





  Widget buttonsWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          WidgetUtils.outlineButton(
            title: '',
            icon: Iconsax.user_add,
            onTap: () {
              Get.dialog(AddCustomerScreen());
            },
            widthFactor: 4.5,
            textColor: ColorUtils.secondaryColor,
            color: ColorUtils.secondaryColor,
          ),
          Spacer(),
          WidgetUtils.softButton(
              title: 'ثبت فاکتور',
              onTap: () {
                if (controller.customerController.isSelected.isFalse) {
                  ViewUtils.showErrorDialog(
                    "لطفا یک مشتری را انتخاب کنید",
                  );
                } else if (controller.factorDescriptionController.text == '') {
                  ViewUtils.showErrorDialog(
                    "لطفا دلایل عدم خرید را وارد کنید",
                  );
                }  else {
                  controller.submit();
                }
              },
              widthFactor: 1.4),

        ],
      ),
    );
  }

}
