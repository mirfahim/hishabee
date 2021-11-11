import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/repositories/product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/repositories/transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/exchange_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/exchange_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/exchange_sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/transaction_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/transaction_sell_controller.dart';

class TransactionsBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<INetworkInfo>(() => NetworkInfo(find()));
    Get.lazyPut<ILocalTransactionProvider>(() => LocalTransactionProvider());
    Get.lazyPut<ITransactionProvider>(() => TransactionProvider(find()));
    Get.lazyPut<ITransactionRepository>(
        () => TransactionRepository(find(), find(), find()));

    Get.lazyPut(() => ExchangePaymentController(find()));
    Get.lazyPut(() => ExchangeController(find()));
    Get.lazyPut(() => TransactionController(find()));

    Get.lazyPut<ILocalProductProvider>(() => LocalProductProvider());
    Get.lazyPut<IProductProvider>(() => ProductProvider(find()));
    Get.lazyPut<IProductRepository>(
        () => ProductRepository(find(), find(), find()));
    Get.lazyPut(() => TransactionSellController(find()));

    Get.lazyPut(() => ExchangeSellController(find()));
  }
}
