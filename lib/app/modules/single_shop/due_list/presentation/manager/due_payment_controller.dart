// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/update_due_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';
//
// class DuePaymentController extends GetxController {
//   final IDueRepository dueRepository;
//   final IAuthRepository authRepository;
//   final updateDueResponse = UpdateDueResponseModel().obs;
//   final givenDue = 0.obs;
//   final dueLeft = 0.obs;
//   final changedAmount = 0.obs;
//   final paying = false.obs;
//
//   final shop = Shop().obs;
//   final due = Due().obs;
//   final cred = Rxn<LoginResponseModel>();
//
//   DuePaymentController(this.dueRepository, this.authRepository);
//
//   Future<void> payDue() async {
//     updateDueResponse.value = await dueRepository.updateDue(
//         shopId: shop.value.id,
//         customerId: due.value.customerId,
//         dueLeft: givenDue.value,
//         customerMobile: due.value.customerMobile);
//     final dlc = Get.find<DueListController>();
//     await dlc.getAllDue();
//   }
//
//   @override
//   void onInit() async {
//     getArguments();
//     await getCred();
//     super.onInit();
//   }
//
//   getArguments() {
//     shop.value = Get.arguments['shop'];
//     due.value = Get.arguments['due'];
//   }
//
//   getCred() async {
//     final result = await authRepository.getCredentials();
//     cred.value = result;
//   }
// }
