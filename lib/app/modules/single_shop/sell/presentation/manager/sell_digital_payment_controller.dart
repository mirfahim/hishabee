import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_digital_payment_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_digital_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';

class SellDigitalPaymentController extends GetConnect {
  final IDigitalPaymentRepository digitalPaymentRepository;

  SellDigitalPaymentController(this.digitalPaymentRepository);

  final due = Due().obs;
  final shop = Shop().obs;
  final givenAmount = 0.obs;
  final url = ''.obs;

  @override
  void onInit() {
    getInitialValue();
    generateLink();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  getInitialValue() {
    shop.value = Get.arguments["shop"];
    due.value = Get.arguments["due"];
    givenAmount.value = Get.arguments["amount"];
  }

  void generateLink() async {
    print("generate link is not working");
    var result = await digitalPaymentRepository.updateDueDigitalPayment(
        shopId: shop.value.id,
        amount: givenAmount.value,
        address: "ojdso",
        customerId: 1,
        customerName: "mie",
        mobileNumber: "124345"
        // address: due.value.customer.address,
        // customerId: due.value.customer.id,
        // customerName: due.value.customer.name,
        // mobileNumber: due.value.customer.mobile
        );
    if (result.code == 200) {
      url.value = result.url;
      Get.to(
        SellDigitalPaymentPage(
          url: result.url,
        ),
      );
    }
  }
}
