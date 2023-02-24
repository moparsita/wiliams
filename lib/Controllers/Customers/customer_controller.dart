import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wiliams/Controllers/Order/order_controller.dart';
import 'package:wiliams/Plugins/get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Models/DbModels/customer_db_model.dart';
import '../../Models/customer_model.dart';
import '../../Models/temp_image_model.dart';
import '../../Plugins/refresher/src/smart_refresher.dart';
import '../../Utils/Api/project_request_utils.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/routing_utils.dart';
import '../../Widgets/Components/choose_source_alert.dart';
import '../../Widgets/form_utils.dart';

class CustomerController extends GetxController {
  final GlobalKey<AnimatedListState> imagesKey = GlobalKey<AnimatedListState>();
  final RxBool customersIsLoading = false.obs;
  final RxBool customerIsLoading = false.obs;
  final RxBool isImageLoading = false.obs;
  final RefreshController refreshController = RefreshController();

  final MyTextController firstNameController = MyTextController();
  final MyTextController lastNameController = MyTextController();
  final MyTextController shopNameController = MyTextController();
  final MyTextController mobileController = MyTextController();
  final MyTextController telController = MyTextController();
  final MyTextController addressController = MyTextController();
  RxInt shopTypeController = 0.obs;
  List<TempImageModel> images = [
    TempImageModel(
      title: "تصویر فروشگاه",
      path: '',
    ),
    TempImageModel(
      title: "تصویر مجوز",
      path: '',
    ),
    TempImageModel(
      title: "تصویر استند",
      path: '',
    ),
  ];

  late CustomerModel customer;
  List<CustomerModel> customers = [];
  int customerId = int.tryParse(Get.currentRoute.split('=').last) ?? 0;

  Future<void> fetchCustomers(String per_page) async {
    customersIsLoading.value = true;
    ApiResult result = await RequestsUtil.instance.data.fetchAllCustomers();
    if (result.isDone) {
      customers = CustomerModel.listFromJson(result.data);
    }
    // List result = await CustomerDbModel()
    //     .getAll();
    // customers = result.map((e) => CustomerModel.fromJson(jsonDecode(e['content']))).toList();
    customersIsLoading.value = false;
  }

  Future<void> fetchCustomerData(String customerId) async {
    customerIsLoading.value = true;
    customer = CustomerDbModel()
        .get(CustomerModel.fromJson, int.parse(customerId)) as CustomerModel;
    customerIsLoading.value = false;
  }

  @override
  void onInit() {
    customerId = int.tryParse(Get.currentRoute.split('=').last) ?? 0;
    print('customerId');
    print(customerId);
    if (customerId > 0) {
      init();
    } else {
      fetchCustomers("10");
    }
    super.onInit();
  }

  Future<void> init() async {
    customerId = int.tryParse(Get.currentRoute.split('=').last) ?? 0;

    if (customerId > 0) {
      fetchCustomerData(customerId.toString());
    } else {
      Future.delayed(const Duration(milliseconds: 150), () {
        Get.back();
      });
    }
  }

  void onRefresh() async {
    await init();
    refreshController.refreshCompleted();
  }

  void addImage(TempImageModel image) async {
    XFile? file = await Get.dialog(
      const ChooseSourceAlert(),
      barrierColor: ColorUtils.black.withOpacity(0.5),
    );
    if (file is XFile) {
      image.isLoading.value = true;
      // ApiResult result = await RequestsUtil.instance.data.adImage(
      //   id: adId,
      //   image: file,
      // );
      image.path = file.path;
      image.isLoading.value = false;
    }
  }

  void submit() async {
    customerIsLoading.value = true;
    ApiResult result = await RequestsUtil.instance.data.addCustomers(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        shopName: shopNameController.text,
        shopType: shopTypeController.value,
        mobile: mobileController.text,
        address: addressController.text,
        tel: telController.text);

    if (result.isDone) {
      CustomerDbModel().truncate();
      List<int> ids =
          await CustomerDbModel().insertAll(List.from(result.data).map((e) {
        return {
          'content': jsonEncode(e),
        };
      }).toList());
      List result2 = await CustomerDbModel().getAll();
      customers = result2
          .map((e) => CustomerModel.fromJson(jsonDecode(e['content'])))
          .toList();
    }
    customerIsLoading.value = false;
    Get.close(1);
    Get.toNamed(
      RoutingUtils.main.name,
    );
  }
}
