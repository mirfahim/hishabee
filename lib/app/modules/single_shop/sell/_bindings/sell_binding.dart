import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/file_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/qr_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/repositories/product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_due_edit_add_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_with_qr_code_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/repositories/transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';

class SellBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider());
    Get.lazyPut<IAuthProvider>(() => AuthProvider(find()));
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));
    Get.lazyPut<IFileProvider>(() => FileProvider(find()));
    Get.lazyPut<IFileRepository>(() => FileRepository(find()));
    Get.lazyPut<IQrProvider>(() => QrProvider(find()));
    Get.lazyPut<IQrRepository>(() => QrRepository(find()));
    Get.lazyPut<ILocalTransactionProvider>(() => LocalTransactionProvider());
    Get.lazyPut<ITransactionProvider>(() => TransactionProvider(find()));
    Get.lazyPut<ITransactionRepository>(
        () => TransactionRepository(find(), find(), find()));
    Get.lazyPut(() => SellWithQrCodeController(find(), find(), find()));
    Get.lazyPut(() => SellDueEditAddController(find(), find(), find()));

    Get.lazyPut<IProductProvider>(() => ProductProvider(find()));
    Get.lazyPut<ILocalProductProvider>(() => LocalProductProvider());
    Get.lazyPut<IProductRepository>(
        () => ProductRepository(find(), find(), find()));
    Get.lazyPut(() => SellController(find(), find(), find(), find()));
  }
}
