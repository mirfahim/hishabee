import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';

class ContactController extends GetxController {
  final employeeList = [].obs;

  final customerList = [].obs;
  final supplierList = [].obs;

  final tabIndex = 0.obs;

  ContactController(this.contactRepository);

  final shop = Rxn<Shop>();

  final IContactRepository contactRepository;

  @override
  onInit() {
    getArguments();

    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllCustomer();
    await getAllSupplier();
    await getAllEmployee();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  getAllEmployee() async {
    try {
      var response =
          await contactRepository.getAllEmployee(shopId: shop.value.id);
      employeeList.assignAll(response);
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }

  getAllSupplier() async {
    // try {
    var response =
        await contactRepository.getAllSupplier(shopId: shop.value.id);

    supplierList.assignAll(response);
    // } catch (e) {
    //   CustomDialog.showStringDialog(e.toString());
    // }
  }

  getAllCustomer() async {
    try {
      var response =
          await contactRepository.getAllCustomer(shopId: shop.value.id);

      customerList.assignAll(response);
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }
}
