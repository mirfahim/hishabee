import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/digital_payment_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/repositories/contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/data_sources/due_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/repositories/due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/repositories/product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_due_edit_add_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/repositories/transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';

class ConfirmPaymentBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<ISHopProvider>(() => ShopProvider(find()));
    Get.lazyPut<ILocalShopProvider>(() => LocalShopProvider());
    Get.lazyPut<IShopRepository>(() => ShopRepository(find(), find(), find()));

    Get.lazyPut<ILocalProductProvider>(() => LocalProductProvider());
    Get.lazyPut<IProductProvider>(() => ProductProvider(find()));
    Get.put<IProductRepository>(ProductRepository(find(), find(), find()));

    Get.lazyPut(
            () => ShopFeaturesController(find(), find(), find(), find(), find()));

    Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider());
    Get.lazyPut<IAuthProvider>(() => AuthProvider(find()));
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));

    Get.lazyPut<ILocalContactProvider>(() => LocalContactProvider());
    Get.lazyPut<IContactProvider>(() => ContactProvider(find()));
    Get.lazyPut<IContactRepository>(
            () => ContactRepository(find(), find(), find()));

    Get.lazyPut<ILocalTransactionProvider>(() => LocalTransactionProvider());
    Get.lazyPut<ITransactionProvider>(() => TransactionProvider(find()));
    Get.lazyPut<ITransactionRepository>(
            () => TransactionRepository(find(), find(), find()));
    Get.lazyPut<IDueProvider>(() => DueProvider(find()));
    Get.lazyPut<IDueRepository>(() => DueRepository(find()));

    Get.lazyPut<IDigitalPaymentProvider>(() => DigitalPaymentProvider(find()));

    Get.lazyPut<IDigitalPaymentRepository>(
            () => DigitalPaymentRepository(find()));

    Get.lazyPut(
            () => ConfirmPaymentController(find(), find(), find(), find(), find()));

    Get.lazyPut<IDueProvider>(() => DueProvider(find()));
    Get.lazyPut<ILocalContactProvider>(() => LocalContactProvider());
    Get.lazyPut<IContactProvider>(() => ContactProvider(find()));
    Get.lazyPut<IDueRepository>(() => DueRepository(find()));
    Get.lazyPut<IContactRepository>(
            () => ContactRepository(find(), find(), find()));
    Get.lazyPut(
            () => SellDueEditAddController(find(), find(),find()));
    Get.lazyPut(
            () => DueFrontController(find()));
  }
}
