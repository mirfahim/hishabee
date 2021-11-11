import 'package:darq/darq.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';

class DueListController extends GetxController {
  final shop = Shop().obs;

  var dueList = <Due>[].obs;
  final searchList = <Due>[].obs;
  var loaded = false.obs;
  var totalDue = 0.obs;

  final IDueRepository dueRepository;

  DueListController(this.dueRepository);

  var totalDueAmount = 0.obs;
  List<Due> dueListA = [];
  int shopId;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllDue();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
  }

  Future<void> getAllDue() async {
    final result = await dueRepository.getAllDue(shopId: shop.value.id);
    final dl = result.due.orderByDescending(
        (element) => element.lastUpdate.microsecondsSinceEpoch);
    dueList.assignAll(dl);
    searchList.assignAll(dl);
    loaded.value = true;
    calculateDue(result.due);
  }

  void calculateDue(List<Due> due) {
    var tDue = 0;
    for (int i = 0; i < due.length; i++) {
      tDue = tDue + due[i].dueAmount;
    }
    totalDue.value = tDue;
  }

  Future<void> searchDue(String searchCustomer) async {
    final result = dueList
        .where((Due due) =>
            due.toString().toLowerCase().contains(searchCustomer.toLowerCase()))
        .toList();
    searchList.assignAll(result);
  }

/*Future<int> totalDue(int shopId) async{
    print("total Due");
      int totalDue = 0;
       var list = await dueListProvider.getDue(shopId);
      if (list!= null) {
        for (int i = 0; i < list.length; i++) {
          totalDue = totalDue + list[i].dueAmount;
          print("From Due Controller index ${i}  ${list[i].dueAmount}");
        }
      }
    //print("From Due Controller ${dueList.value[0].dueAmount}");
    return totalDue;
  }*/
}
