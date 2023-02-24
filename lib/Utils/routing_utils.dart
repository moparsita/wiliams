import 'package:wiliams/Plugins/get/get.dart';
import 'package:wiliams/Views/DrawerData/faq_screen.dart';
import 'package:wiliams/Views/DrawerData/support_screen.dart';
import 'package:wiliams/Views/Customers/customers.dart';
import 'package:wiliams/Views/Order/add_order.dart';
import 'package:wiliams/Views/Order/orders.dart';
import 'package:wiliams/Views/Order/unsuccessful_orders.dart';
import 'package:wiliams/Views/Splash/splash_screen.dart';

import '../Views/DrawerData/about_screen.dart';
import '../Views/DrawerData/guide_screen.dart';
import '../Views/Order/add_unsuccessful_order.dart';
import '../Views/Products/products.dart';
import '../Views/Home/home_screen.dart';
import '../Views/Login/login_screen.dart';
import '../Views/Order/order_details.dart';
import '../Views/Profile/profile_screen.dart';
import '../Views/main_screen.dart';


class RoutingUtils {
  static GetPage splash = GetPage(
    name: '/',
    transition: Transition.fade,
    page: () => SplashScreen(),
  );

  static GetPage main = GetPage(
    name: '/main',
    transition: Transition.fade,
    page: () => MainScreen(),
  );

  static GetPage support = GetPage(
    name: '/support',
    transition: Transition.fade,
    page: () => SupportScreen(),
  );

  static GetPage guide = GetPage(
    name: '/guide',
    transition: Transition.fade,
    page: () => GuideScreen(),
  );

  static GetPage about = GetPage(
    name: '/about',
    transition: Transition.fade,
    page: () => AboutScreen(),
  );

  static GetPage faq = GetPage(
    name: '/faq',
    transition: Transition.fade,
    page: () => FaqScreen(),
  );

  static GetPage home = GetPage(
    name: '/home',
    transition: Transition.fade,
    page: () => HomeScreen(),
  );

  static GetPage login = GetPage(
    name: '/login',
    transition: Transition.fade,
    page: () => LoginScreen(),
  );

  static GetPage profile = GetPage(
    name: '/profile',
    transition: Transition.fade,
    page: () => ProfileScreen(),
  );

  static GetPage products = GetPage(
    name: '/product',
    transition: Transition.fade,
    page: () => ProductsScreen(),
  );

  static GetPage product = GetPage(
    name: '/product',
    transition: Transition.fade,
    page: () => ProfileScreen(),
  );

  static GetPage orders = GetPage(
    name: '/orders',
    transition: Transition.fade,
    page: () => OrdersScreen(),
  );

  static GetPage unsuccessfulOrders = GetPage(
    name: '/unsuccessfulOrders',
    transition: Transition.fade,
    page: () => UnsuccessfulOrdersScreen(),
  );

  static GetPage order = GetPage(
    name: '/order',
    transition: Transition.fade,
    page: () => OrderDetailsScreen(),
  );

  static GetPage addOrder = GetPage(
    name: '/addOrder',
    transition: Transition.fade,
    page: () => AddOrderScreen(),
  );

  static GetPage addUnsuccessfulOrder = GetPage(
    name: '/addUnsuccessfulOrder',
    transition: Transition.fade,
    page: () => AddUnsuccessfulOrderScreen(),
  );



static GetPage customers = GetPage(
    name: '/customers',
    transition: Transition.fade,
    page: () => CustomersScreen(),
  );





}
