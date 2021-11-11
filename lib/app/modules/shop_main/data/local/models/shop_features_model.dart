import 'package:get/get.dart';

class ShopFeature {
  int type;
  String featureName;
  String imgPath;

  ShopFeature({
    this.type,
    this.featureName,
    this.imgPath,
  });
}

List<ShopFeature> listOfShopFeature = [
  ShopFeature(
    type: 1,
    featureName: "stock_amp_audit".tr,
    imgPath: "images/shop_features/stock.png",
  ),
  ShopFeature(
    type: 2,
    featureName: "dueList".tr,
    imgPath: "images/shop_features/duelist.png",
  ),
  ShopFeature(
    type: 3,
    featureName: "product_list".tr,
    imgPath: "images/shop_features/productList.png",
  ),
  ShopFeature(
    type: 4,
    featureName: "reports".tr,
    imgPath: "images/shop_features/report.png",
  ),
  ShopFeature(
    type: 5,
    featureName: "sell_pos".tr,
    imgPath: "images/shop_features/sell.png",
  ),
  ShopFeature(
    type: 6,
    featureName: "notification".tr,
    imgPath: "images/shop_features/notifications.png",
  ),
  ShopFeature(
    type: 7,
    featureName: "online_orders".tr,
    imgPath: "images/shop_features/onlineOrders.png",
  ),
  ShopFeature(
    type: 8,
    featureName: "transaction_exchange_amp_refund".tr,
    imgPath: "images/shop_features/transcation.png",
  ),
  ShopFeature(
    type: 9,
    featureName: "expenses".tr,
    imgPath: "images/shop_features/expenses.png",
  ),
  ShopFeature(
    type: 10,
    featureName: "calculator".tr,
    imgPath: "images/shop_features/calculator.png",
  ),
  ShopFeature(
    type: 11,
    featureName: "contact".tr,
    imgPath: "images/shop_features/contacts.png",
  ),
  ShopFeature(
    type: 12,
    featureName: "app_setting".tr,
    imgPath: "images/shop_features/settings.png",
  ),
];
