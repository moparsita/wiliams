import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wiliams/Globals/Globals.dart';
import 'package:wiliams/Models/DbModels/product_db_model.dart';
import 'package:wiliams/Models/customer_model.dart';
import 'package:wiliams/Plugins/get/get.dart';
import 'package:wiliams/Plugins/my_dropdown/dropdown_item_model.dart';
import 'package:wiliams/Utils/location_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

import '../../Models/DbModels/customer_db_model.dart';
import '../../Models/DbModels/order_db_model.dart';
import '../../Models/factor_model.dart';
import '../../Models/order_model.dart';
import '../../Models/product_model.dart';
import '../../Models/unsuccessful_order_model.dart';
import '../../Plugins/get/get_core/src/get_main.dart';
import '../../Plugins/get/get_rx/src/rx_types/rx_types.dart';
import '../../Plugins/get/get_state_manager/src/simple/get_controllers.dart';
import '../../Plugins/my_dropdown/dropdown_controller.dart';
import '../../Plugins/refresher/pull_to_refresh.dart';
import '../../Utils/Api/project_request_utils.dart';
import '../../Utils/routing_utils.dart';
import '../../Utils/view_utils.dart';
import '../../Views/Order/Widgets/change_status_widget.dart';
import '../../Views/Order/Widgets/order_pagination_widget.dart';
import '../../Views/Order/Widgets/sort_order_widget.dart';
import '../../Widgets/form_utils.dart';

class UnsuccessfulOrderController extends GetxController {
  final RxBool ordersIsLoading = false.obs;
  final RefreshController refreshController = RefreshController();
  final RxString statusType = 'تکمیل شده'.obs;
  final DropdownController customerController = DropdownController();
  final MyTextController factorDescriptionController = MyTextController();
  late final List<MyTextController> productController;
  List<CustomerModel> customers = [];
  List<ProductModel> products = [];
  late List<String> listOfCustomers;

  LocationData? currentLocation;
  String myLatitude = '';
  String myLongitude = '';
  Future<void> getCurrentLocation() async {
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    myLatitude = currentLocation!.latitude.toString();
    myLongitude = currentLocation!.longitude.toString();


  }

  late ProductModel product;
  List<UnsuccessfulFactorModel> orders = [];
  late UnsuccessfulFactorModel singleFactor;

  int orderId = int.tryParse(Get.currentRoute.split('=').last) ?? 0;



  @override
  void onInit() {

    super.onInit();
  }


  Future<void> fetchFactors() async {
    ordersIsLoading.value = true;
    ApiResult result = await RequestsUtil.instance.data.fetchUnsuccessfulFactors();
    if(result.isDone) {
      orders = UnsuccessfulFactorModel.listFromJson(result.data);
    }
    ordersIsLoading.value = false;

  }


  void onRefresh() async {
    refreshController.refreshCompleted();
  }




  void submit() async{

    await getCurrentLocation();
    ordersIsLoading.value = true;
    ApiResult result = await RequestsUtil.instance.data.addUnsuccessfulOrder(
        customerId: customerController.value.dropdownId().toString(),
        visitorId: Globals.userStream.user!.id.toString(),
        factorDescription: factorDescriptionController.text,
        Location: myLatitude + ',' + myLongitude,

    );

    if(result.isDone){
      ViewUtils.showSuccessDialog(
        "ثبت فاکتور با موفقیت انجام شد",
      );
      Future.delayed(const Duration(seconds: 3), () {
        Get.toNamed(RoutingUtils.main.name);
      });
    } else {
      ViewUtils.showErrorDialog(
        "خطا در ثبت فاکتور",
      );
    }
    ordersIsLoading.value = false;

  }
}
