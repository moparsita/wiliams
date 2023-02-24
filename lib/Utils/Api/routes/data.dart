import 'dart:convert';
import 'dart:io';

import 'package:wiliams/Globals/Globals.dart';
import 'package:wiliams/Utils/Api/WebControllers.dart';
import 'package:wiliams/Utils/Api/project_request_utils.dart';

class DataApi {

  Future<ApiResult> fetchAllProducts() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'allProducts',
      postRequest: false,
      auth: true,
    );
  }

  Future<ApiResult> fetchAllCustomers() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'allCustomers',
      postRequest: false,
      auth: true,
    );
  }

  Future<ApiResult> fetchAllFactors() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'allFactors',
      postRequest: true,
      body: {
        'visitorId': Globals.userStream.user!.id.toString(),
      },
      auth: true,
    );
  }

  Future<ApiResult> fetchUnsuccessfulFactors() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'UnsuccessfulFactors',
      postRequest: true,
      body: {
        'visitorId': Globals.userStream.user!.id.toString(),
      },
      auth: true,
    );
  }

  Future<ApiResult> addCustomers({
    required String firstName,
    required String lastName,
    required String shopName,
    required int shopType,
    required String mobile,
    required String address,
    required String tel
  }) async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'addCustomer',
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'shopName': shopName,
        'shopType': shopType,
        'mobile': mobile,
        'address': address,
        'tel': tel,
      },
      postRequest: true,
      auth: true,
    );
  }

  Future<ApiResult> addOrder({
    required String customerId,
    required String visitorId,
    required String factorNumber,
    required String factorType,
    required String totalPrice,
    required String posPay,
    required String cardPay,
    required String cashPay,
    required String chequePay,
    required String amountRemain,
    required String Products,
    required String Location,
  }) async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'addOrder',
      body: {
        'customerId': customerId,
        'visitorId': visitorId,
        'factorNumber': factorNumber,
        'factorType': factorType,
        'totalPrice': totalPrice,
        'posPay': posPay,
        'cardPay': cardPay,
        'cashPay': cashPay,
        'chequePay': chequePay,
        'amountRemain': amountRemain,
        'Products': Products,
        'Location': Location,
      },
      postRequest: true,
      auth: true,
    );
  }

  Future<ApiResult> addUnsuccessfulOrder({
    required String customerId,
    required String visitorId,
    required String factorDescription,
    required String Location,
  }) async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'addUnsuccessfulOrder',
      body: {
        'customerId': customerId,
        'visitorId': visitorId,
        'factorDescription': factorDescription,
        'Location': Location,
      },
      postRequest: true,
      auth: true,
    );
  }

  Future<ApiResult> sendLocation({
    required String Location,
  }) async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'setLocation',
      body: {
        'visitorId': Globals.userStream.user!.id.toString(),
        'Location': Location,
      },
      postRequest: true,
      auth: true,
    );
  }


  Future<ApiResult> getData({required String visitorId}) async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'getData',
        body: {
          'visitorId': visitorId,
        },
      postRequest: true,
      auth: true,
    );
  }


  Future<ApiResult> about() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'about-us',
      postRequest: false,
      auth: true,
    );
  }

  Future<ApiResult> invite() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'invite',
      postRequest: false,
      auth: true,
    );
  }
  Future<ApiResult> support() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'support',
      postRequest: false,
      auth: true,
    );
  }
  Future<ApiResult> guide() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'guide',
      postRequest: false,
      auth: true,
    );
  }

  Future<ApiResult> faq() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'host-questions',
      postRequest: false,
      auth: true,
    );
  }

  Future<ApiResult> drawerData() async {
    return RequestsUtil.instance.makeRequest(
      webController: WebControllers.data,
      webMethod: 'drawer-data',
      postRequest: false,
      auth: true,
    );
  }


}
