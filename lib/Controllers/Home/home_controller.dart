import 'dart:async';
import 'package:flutter/services.dart';
import 'package:wiliams/Plugins/get/get.dart';
import '../../Globals/Globals.dart';
import '../../Models/product_model.dart';
import '../../Plugins/refresher/pull_to_refresh.dart';
import '../../Utils/Api/project_request_utils.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
class HomeController extends GetxController {
  static const MethodChannel methodChannel = MethodChannel('today.parsa.wiliams/printer');
  final RxBool isLoading = true.obs;
  final RefreshController refreshController = RefreshController();
  final RxString sortType = 'ارزانترین'.obs;
  final List<String> sortTypes = [
    'ارزانترین',
    'گرانترین',
    'جدید ترین',
    'قدیمی ترین',
    'محبوب ترین',
    'پرامتیاز ترین',
  ];

  final RxString perPage = '10'.obs;
  final List<String> perPages = [
    '10',
    '20',
    '50',
    '100',
  ];

  StreamSubscription<String?>? sortStream;
  StreamSubscription<String?>? pageStream;
  List<ProductModel> products = [];

  int todaySale = 0;
  int todayPrice = 0;
  int allTimeSale = 0;
  int allTimePrice = 0;

  Future<void> fetchData() async {
    isLoading.value = true;


    ApiResult result = await RequestsUtil.instance.data.getData(
        visitorId: Globals.userStream.user!.id.toString());
    todaySale = result.data['todaySale'];
    todayPrice = result.data['todayPrice'];
    allTimeSale = result.data['allTimeSale'];
    allTimePrice = result.data['allTimePrice'];
    isLoading.value = false;
  }
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }



  void onRefresh() async {
    await fetchData();
    refreshController.refreshCompleted();
  }
  void testReceipt(NetworkPrinter printer) {
    printer.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: 'CP1252'));
    printer.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: 'CP1252'));

    printer.text('Bold text', styles: PosStyles(bold: true));
    printer.text('Reverse text', styles: PosStyles(reverse: true));
    printer.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    printer.text('Align left', styles: PosStyles(align: PosAlign.left));
    printer.text('Align center', styles: PosStyles(align: PosAlign.center));
    printer.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    printer.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    printer.feed(2);
    printer.cut();
  }

  printFactor() async {
    try {
      await methodChannel.invokeMethod('printFactor');
      print('result');
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }


  }
}
