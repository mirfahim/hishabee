
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_item_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_item_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_unuque_id.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';
import 'package:http/http.dart';

import '../../data/remote/models/get_all_due_item_by_uniq_id.dart';
import 'due_list_controller.dart';

class DueDetailsController extends GetxController{
  final dueItem = <GetAllDueItemByUid>[].obs;
  final selectedDueItem =  GetAllDueItemByUid().obs;
  final due = Due().obs;
  final shop = Shop().obs;
  final dueDate = DateTime.now().obs;
  final dueLeft = 0.0.obs;

  final IDueRepository dueRepository;
  DueDetailsController(this.dueRepository);

  getAllDueItem() async{
    var filterList = <GetAllDueItemByUid>[];
    var tempList = <GetAllDueItemByUid>[];
    final result = await dueRepository.getAllDueItemByUid(uid: due.value.uniqueId);
    filterList.assignAll(result);
    filterList.forEach((element) {
      if(element.version != null && element.version > 0){
        tempList.add(element);
      }
    });
    dueItem.assignAll(tempList);
    claCulateLeftDue(dueItem);
  }
  claCulateLeftDue(List<GetAllDueItemByUid> dueItemList){
    var positive = 0.0;
    var negative = 0.0;
    dueItemList.forEach((element) {
      if(element.amount > 0){
        positive = positive + element.amount;
      }else{
        negative = negative - element.amount;
      }
    });
    dueLeft.value = positive - negative;
  }
  getArguments() {
    due.value = Get.arguments['due'];
    shop.value = Get.arguments['shop'];
  }
  @override
  void onInit() {
    getArguments();
    getAllDueItem();
    super.onInit();
  }
  deleteDue() async{
    CustomDialog.showLoadingDialog(message: 'Deleting Due');
    AddDueRequest request = AddDueRequest(contactName: due.value.contactName, contactMobile: due.value.contactMobile,contactType: due.value.contactType,updatedAt: DateTime.now().toString(),createdAt: due.value.createdAt.toString(),version: -1,uniqueId: due.value.uniqueId,shopId: due.value.shopId,amount: due.value.dueAmount);
    final response = await dueRepository.addNewDue(request);
    Get.back();
    if(response.code == 200){
      Get.find<DueFrontController>().getAllDue().then((value){
        Get.back();
      });
    }
  }

  deleteDueItem() async{
    var leftAmount;
    selectedDueItem.value.amount > 0 ? leftAmount = dueLeft.value - selectedDueItem.value.amount : leftAmount = dueLeft.value + selectedDueItem.value.amount;
    CustomDialog.showLoadingDialog(message: 'Deleting Due');
    AddDueItemRequest request = AddDueItemRequest(amount: selectedDueItem.value.amount,shopId: selectedDueItem.value.shopId,uniqueId: selectedDueItem.value.uniqueId,version: -1,dueUniqueId: selectedDueItem.value.dueUniqueId.toString(),createdAt: selectedDueItem.value.createdAt.toString(),updatedAt: DateTime.now().toString(),dueLeft: leftAmount);
    final response = await dueRepository.addNewDueItem(request);
    Get.back();
    if(response.code == 200){
      Get.find<DueDetailsController>().getAllDueItem().then((value){
        Get.back();
      });
    }
  }
}