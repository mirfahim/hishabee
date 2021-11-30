import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/account_information_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/digital_payment_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/qr_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/subscription_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/training_video_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/account_information_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/subscription_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/repositories/training_video_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_account_information_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_subscription_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_training_video_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/set_qr_code_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/settings_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/subscription_page_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/training_video_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/withdraw_request_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/repositories/contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/data_sources/due_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/repositories/due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/repositories/transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';

class AppSettingsBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
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

    Get.lazyPut<ILocalContactProvider>(() => LocalContactProvider());
    Get.lazyPut<IContactProvider>(() => ContactProvider(find()));
    Get.lazyPut<IContactRepository>(
        () => ContactRepository(find(), find(), find()));

    Get.lazyPut<IDigitalPaymentProvider>(() => DigitalPaymentProvider(find()));

    Get.lazyPut<IDigitalPaymentRepository>(
        () => DigitalPaymentRepository(find()));

    Get.lazyPut(
        () => ConfirmPaymentController(find(), find(), find(), find(), find()));

    Get.lazyPut<IDueProvider>(() => DueProvider(find()));
    Get.lazyPut<IDueRepository>(() => DueRepository(find()));
    Get.lazyPut(() => DuePaymentController(find(), find()));

    Get.lazyPut<IQrProvider>(() => QrProvider(find()));
    Get.lazyPut<IQrRepository>(() => QrRepository(find()));
    Get.lazyPut(() => SetQrCodeController(find(), find()));
    Get.lazyPut<ILocalizationService>(() => LocalizationService());

    // Get.lazyPut<ISSLCommerzPaymentProvider>(() => SSLCommerzPaymentProvider());
    Get.lazyPut<ISubscriptionProvider>(() => SubscriptionProvider(find()));

    Get.lazyPut<ISubscriptionRepository>(() => SubscriptionRepository(find()));
    // Get.lazyPut<ISSLCommerzPaymentRepository>(
    //     () => SSLCommerzPaymentRepository(find()));

    Get.lazyPut(() => SettingsController(find(), find()));

    Get.lazyPut(() => WithdrawRequestController(find()));

    Get.lazyPut<ITrainingVideoProvider>(() => TrainingVideoProvider(find()));

    Get.lazyPut<ITrainingVideoRepository>(
        () => TrainingVideoRepository(find()));

    Get.lazyPut(() => TrainingVideoController(find()));

    Get.lazyPut<IAccountInformationProvider>(
        () => AccountInformationProvider(find()));
    Get.lazyPut<IAccountInformationRepository>(
        () => AccountInformationRepository(find()));
    Get.lazyPut(() => SubscriptionPageController(find()));
  }
}
