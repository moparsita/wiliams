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
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../../Models/DbModels/customer_db_model.dart';
import '../../Models/DbModels/order_db_model.dart';
import '../../Models/factor_model.dart';
import '../../Models/order_model.dart';
import '../../Models/product_model.dart';
import '../../Models/temp_image_model.dart';
import '../../Plugins/get/get_core/src/get_main.dart';
import '../../Plugins/get/get_rx/src/rx_types/rx_types.dart';
import '../../Plugins/get/get_state_manager/src/simple/get_controllers.dart';
import '../../Plugins/my_dropdown/dropdown_controller.dart';
import '../../Plugins/refresher/pull_to_refresh.dart';
import '../../Utils/Api/project_request_utils.dart';
import '../../Utils/color_utils.dart';
import '../../Utils/routing_utils.dart';
import '../../Utils/view_utils.dart';
import '../../Views/Order/Widgets/change_status_widget.dart';
import '../../Views/Order/Widgets/order_pagination_widget.dart';
import '../../Views/Order/Widgets/sort_order_widget.dart';
import '../../Widgets/Components/choose_source_alert.dart';
import '../../Widgets/form_utils.dart';

class OrderController extends GetxController {
  final RxBool ordersIsLoading = false.obs;
  final RefreshController refreshController = RefreshController();
  final RxString statusType = 'تکمیل شده'.obs;
  final DropdownController customerController = DropdownController();
  final MyTextController factorNumberController = MyTextController();
  final MyTextController remainController = MyTextController();
  final MyTextController payPosController = MyTextController();
  final MyTextController payCashController = MyTextController();
  final MyTextController payCardController = MyTextController();
  final MyTextController payChequeController = MyTextController();
  final MyTextController totalPriceController = MyTextController();
  late final List<MyTextController> productController;
  List<TempImageModel> images = [
    TempImageModel(
      title: "رسید",
      path: '',
    ),
    TempImageModel(
      title: "رسید",
      path: '',
    ),
    TempImageModel(
      title: "رسید",
      path: '',
    ),
    TempImageModel(
      title: "رسید",
      path: '',
    ),
  ];

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
  late LocationData locationData;
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
  RxInt factorTypeController = 0.obs;
  int totalPrice = 0;
  int remain = 0;
  List<CustomerModel> customers = [];
  List<ProductModel> products = [];
  late List<String> listOfCustomers;
  final List<String> statusTypes = [
    'تکمیل شده',
    'لغو شده',
    'ناموفق',
    'در انتظار پرداخت',
    'در حال انجام',
    'در انتظار بررسی',
    'مسترد شده',
    'پیش نویس',
  ];
  final RxString sortType = 'همه سفارشات'.obs;
  final List<String> sortTypes = [
    'همه سفارشات',
    'تکمیل شده',
    'لغو شده',
    'ناموفق',
    'در انتظار پرداخت',
    'در حال انجام',
    'در انتظار بررسی',
    'مسترد شده',
    'پیش نویس',
  ];
  String status = "all";
  final RxString perPage = '10'.obs;
  final List<String> perPages = [
    '10',
    '20',
    '50',
    '100',
  ];
  StreamSubscription<String?>? sortStream;
  StreamSubscription<String?>? pageStream;
  StreamSubscription<String?>? statusStream;
  late OrderModel order;
  late CustomerModel customer;
  late ProductModel product;
  List<FactorModel> orders = [];
  late FactorModel singleFactor;


  int orderId = int.tryParse(Get.currentRoute.split('=').last) ?? 0;



  @override
  void onInit() {

    fetchCustomers();
    super.onInit();
  }

  Future<void> init() async {

    orderId = int.tryParse(Get.currentRoute.split('=').last) ?? 0;
    if (orderId > 0) {
      // fetchSingleOrder(orderId.toString());
    } else {
      Future.delayed(const Duration(milliseconds: 150), () {
        Get.back();
      });
    }
  }

  Future<void> fetchFactors() async {
    ordersIsLoading.value = true;
    ApiResult result = await RequestsUtil.instance.data.fetchAllFactors();
    if(result.isDone) {
      orders = FactorModel.listFromJson(result.data);
    }
    ordersIsLoading.value = false;

  }
  void calculateTotalPrice(String string) {
    int num = products.length;
    totalPrice = 0;
    int amount = 0;
    for(int i=0; i<num; i++){
      amount = int.tryParse(productController[i].text) ?? 0;
      totalPrice += int.parse(products[i].price) * amount;
    }
    int remain = totalPrice;
    int pos = int.tryParse(payPosController.text) ?? 0;
    int card = int.tryParse(payCardController.text) ?? 0;
    int cash = int.tryParse(payCashController.text) ?? 0;
    int cheque = int.tryParse(payChequeController.text) ?? 0;

    remain = totalPrice - pos - card - cash - cheque;
    totalPriceController.text = totalPrice.toString();
    remainController.text = remain.toString();
  }

  void calculateRemain(String string) {
    totalPrice = int.tryParse(totalPriceController.text) ?? 0;
    int pos = int.tryParse(payPosController.text) ?? 0;
    int card = int.tryParse(payCardController.text) ?? 0;
    int cash = int.tryParse(payCashController.text) ?? 0;
    int cheque = int.tryParse(payChequeController.text) ?? 0;

    remain = totalPrice - pos - card - cash - cheque;
    remainController.text = remain.toString();
  }

  Future<void> fetchCustomers() async {
    // locationData = await LocationUtils.getLocation();

    ordersIsLoading.value = true;
    ApiResult result = await RequestsUtil.instance.data.fetchAllProducts();
    if(result.isDone) {
      products = ProductModel.listFromJson(result.data);
    }

    result = await RequestsUtil.instance.data.fetchAllCustomers();
    if(result.isDone) {
      customerController.items = CustomerModel.listFromJson(result.data);
    }

    productController = List.generate(products.length, (i) => MyTextController());
    ordersIsLoading.value = false;

  }
  void onRefresh() async {
    await init();
    refreshController.refreshCompleted();
  }

  void showSort() async {
    String str = sortType.value;
    sortStream?.cancel();
    sortStream = sortType.stream.listen((event) {
      Get.close(1);
    });
    await Get.bottomSheet(
      OrderSortWidget(),
    );
    if (str != sortType.value) {
      switch (sortType.value) {
        case 'همه سفارشات':
          status = "all";
          break;
        case 'درانتظار پرداخت':
          status = "pending";
          break;
        case 'در حال انجام':
          status = "processing";
          break;
        case 'در انتظار بررسی':
          status = "on-hold";
          break;
        case 'تکمیل شده':
          status = "completed";
          break;
        case 'لغو شده':
          status = "cancelled";
          break;
        case 'مسترد شده':
          status = "refunded";
          break;
        case 'ناموفق':
          status = "failed";
          break;
        case 'پیش نویس':
          status = "checkout-draft";
          break;
        default:
          status = "all";
      }
      ordersIsLoading.value = true;
      ordersIsLoading.value = false;
    }
  }

  void showPage() async {
    String str = perPage.value;
    pageStream?.cancel();
    pageStream = perPage.stream.listen((event) {
      Get.close(1);
    });
    await Get.bottomSheet(
      OrderPaginationWidget(),
    );
    if (str != perPage.value) {
      ordersIsLoading.value = true;
      ordersIsLoading.value = false;
    }
  }

  showStatus(int id) async {
    String str = statusType.value;
    statusStream?.cancel();
    statusStream = statusType.stream.listen((event) {
      Get.close(1);
    });
    await Get.bottomSheet(
      ChangeStatusWidget(),
    );
    if (str != statusType.value) {
      switch (statusType.value) {
        case 'درانتظار پرداخت':
          status = "pending";
          break;
        case 'در حال انجام':
          status = "processing";
          break;
        case 'در انتظار بررسی':
          status = "on-hold";
          break;
        case 'تکمیل شده':
          status = "completed";
          break;
        case 'لغو شده':
          status = "cancelled";
          break;
        case 'مسترد شده':
          status = "refunded";
          break;
        case 'ناموفق':
          status = "failed";
          break;
        case 'پیش نویس':
          status = "checkout-draft";
          break;
        default:
          status = "";
      }

    }
  }

  void submit() async{
    print('submit');
    Map<String,String> sendProducts = {};
    int num = products.length;
    int amount;
    for(int i=0; i<num; i++){
      amount = int.tryParse(productController[i].text) ?? 0;
      if(amount > 0){
        if(sendProducts.containsKey(products[i].id)){
          sendProducts.update(products[i].id.toString(), (value) => value + amount.toString());
        } else {
          sendProducts[products[i].id.toString()] = amount.toString();
        }
      }
    }
    String jsonProducts = jsonEncode(sendProducts);
    ordersIsLoading.value = true;
    getCurrentLocation();
    ApiResult result = await RequestsUtil.instance.data.addOrder(
        customerId: customerController.value.dropdownId().toString(),
        visitorId: Globals.userStream.user!.id.toString(),
        factorNumber: factorNumberController.text,
        factorType: factorTypeController.value.toString(),
        totalPrice: totalPriceController.text,
        posPay: payPosController.text,
        cardPay: payCardController.text,
        cashPay: payCashController.text,
        chequePay: payChequeController.text,
        amountRemain: remainController.text,
        Products: jsonProducts,
        Location: myLatitude + ',' + myLongitude,

    );

    if(result.isDone){

      ViewUtils.showSuccessDialog(
        "ثبت فاکتور با موفقیت انجام شد",
      );
      factorNumberController.text = '';
      remainController.text = '';
      payPosController.text = '';
      payCashController.text = '';
      payCardController.text = '';
      payChequeController.text = '';
      totalPriceController.text = '';
      for(int i=0; i<num; i++) {
        productController[i].text = '';
      }
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
