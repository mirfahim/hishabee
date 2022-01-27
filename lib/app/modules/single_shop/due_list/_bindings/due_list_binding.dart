import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/file_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/digital_payment_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/qr_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/repositories/contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/data_sources/due_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/repositories/due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/add_due_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_digital_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/pay_due_qr_code_controller.dart';

import '../presentation/manager/add_edit_due_controller.dart';
import '../presentation/manager/due_details_controller.dart';

class DueListBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider());
    Get.lazyPut<IAuthProvider>(() => AuthProvider(find()));
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));

    Get.lazyPut<IDueProvider>(() => DueProvider(find()));
    Get.lazyPut<INetworkInfo>(() => NetworkInfo(find()));
    Get.lazyPut<ILocalContactProvider>(() => LocalContactProvider());
    Get.lazyPut<IContactProvider>(() => ContactProvider(find()));
    Get.lazyPut<IDueRepository>(() => DueRepository(find()));
    Get.lazyPut<IContactRepository>(
        () => ContactRepository(find(), find(), find()));
    Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider());
    Get.lazyPut<IAuthProvider>(() => AuthProvider(find()));
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));
    Get.lazyPut<IFileProvider>(() => FileProvider(find()));
    Get.lazyPut<IFileRepository>(() => FileRepository(find()));
    Get.lazyPut<IQrProvider>(() => QrProvider(find()));
    Get.lazyPut<IQrRepository>(() => QrRepository(find()));
    // Get.lazyPut(() => PayDueQrCodeController(find(), find(), find()));
    // Get.lazyPut(() => AddDueController(find(), find()));
    // Get.lazyPut(() => DueListController(find()));
    // Get.lazyPut(() => DuePaymentController(find(), find()));
    Get.lazyPut<IDigitalPaymentProvider>(() => DigitalPaymentProvider(find()));
    Get.lazyPut<IDigitalPaymentRepository>(
        () => DigitalPaymentRepository(find()));
    // Get.lazyPut(() => DueDigitalPaymentController(find()));
    Get.lazyPut(() => DueFrontController(find()));
    Get.lazyPut(() => DueDetailsController(find()));
    Get.lazyPut<ILocalContactProvider>(
            () => LocalContactProvider());
    Get.lazyPut<IContactProvider>(
            () => ContactProvider(find()));
    Get.lazyPut<IContactRepository>(
            () => ContactRepository(find(),find(),find()));
    Get.lazyPut(() => DueEditAddController(find(),find()));
  }
}
