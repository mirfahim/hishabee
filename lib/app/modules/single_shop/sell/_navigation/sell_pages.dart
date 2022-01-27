import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/confirm_payment_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/sell_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_navigation/sell_page_route.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/confirm_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_due_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_with_qr_code_page.dart';
import 'package:hishabee_business_manager_fl/new_UI/quick_sell/quick_sell_front.dart';

import '../presentation/pages/sell_cart_page.dart';

abstract class SellPage{
static List<GetPage> pages = [
  GetPage(name: SellPageRoutes.SELL_PAGE, page:()=> QuickSell(),binding: SellBinding()),
  GetPage(name: SellPageRoutes.SELL_CART_PAGE, page: ()=> SellCartPage(), binding: SellBinding()),
  GetPage(
    name: SellPageRoutes.CONFIRM_PAYMENT_PAGE,
    page: () => ConfirmPaymentPage(),
    binding: ConfirmPaymentBinding(),
  ),
  GetPage(
    name: SellPageRoutes.SELL_DUE_PAGE,
    page: () => SellDue(),
    binding: ConfirmPaymentBinding(),
  ),
  GetPage(
    name: SellPageRoutes.SELL_QR_PAGE,
    page: () => SellWithQRCodePage(),
    binding: SellBinding(),
  ),
];
}