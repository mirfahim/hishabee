// import 'package:get/get.dart';
// import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
// import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_shop_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/shop_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/repositories/product_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/data/remote/data_sources/wallet_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/data/repositories/wallet_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/domain/repositories/wallet_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/digital_balance_page_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/web_view_page_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/repositories/transaction_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
//
// class SMSBindings extends Bindings {
//   static final find = Get.find;
//
//   @override
//   void dependencies() {
//     Get.lazyPut(() => WebViewPageController(find()));
//
//     Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider());
//     Get.lazyPut<IAuthProvider>(() => AuthProvider(find()));
//     Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));
//
//     Get.lazyPut<INetworkInfo>(() => NetworkInfo(find()));
//     Get.lazyPut<ILocalProductProvider>(() => LocalProductProvider());
//     Get.lazyPut<IProductProvider>(() => ProductProvider(find()));
//     Get.put<IProductRepository>(ProductRepository(find(), find(), find()));
//     Get.lazyPut<ILocalTransactionProvider>(() => LocalTransactionProvider());
//     Get.lazyPut<ITransactionProvider>(() => TransactionProvider(Get.find()));
//     Get.lazyPut<ITransactionRepository>(
//         () => TransactionRepository(Get.find(), Get.find(), Get.find()));
//
//     Get.lazyPut<ISHopProvider>(() => ShopProvider(find()));
//     Get.lazyPut<ILocalShopProvider>(() => LocalShopProvider());
//     Get.lazyPut<IShopRepository>(() => ShopRepository(find(), find(), find()));
//
//     Get.lazyPut<IWalletProvider>(() => WalletProvider(find()));
//     Get.lazyPut<IWalletRepository>(() => WalletRepository(find()));
//     Get.lazyPut(() => DigitalBalancePageController(find(), find()));
//
//     Get.lazyPut(
//         () => ShopFeaturesController(find(), find(), find(), find(), find()));
//   }
// }
