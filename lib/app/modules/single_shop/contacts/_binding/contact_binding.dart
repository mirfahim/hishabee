import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_salary_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/salary_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/repositories/contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/repositories/salary_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_salary_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/add_contact_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/contact_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/edit_contact_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/salary_report_controller.dart';

class ContactBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<IContactProvider>(() => ContactProvider(find()));
    Get.lazyPut<ILocalContactProvider>(() => LocalContactProvider());
    Get.lazyPut<IContactRepository>(
        () => ContactRepository(find(), find(), find()));
    Get.lazyPut(() => ContactController(find()));
    Get.lazyPut(() => AddContactsController(find(), find()));
    Get.lazyPut(() => EditContactsController(find(), find()));

    Get.lazyPut<ISalaryProvider>(() => SalaryProvider(find()));
    Get.lazyPut<ILocalSalaryProvider>(() => LocalSalaryProvider());
    Get.lazyPut<ISalaryRepository>(
        () => SalaryRepository(find(), find(), find()));
    Get.lazyPut(() => SalaryReportController(find()));
  }
}
