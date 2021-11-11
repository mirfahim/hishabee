import 'dart:io';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/nid_verify_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';

class NidVerificationController extends GetxController {
  final IAuthRepository _authRepository;

  NidVerificationController(this._authRepository);

  final nidVerificationResponseModel = NidVerifyResponseModel().obs;

  final nidNumber = ''.obs;
  final nidFront = Rxn<File>();
  final nidBack = Rxn<File>();

  verifyNid() async {
    CustomDialog.showLoadingDialog(message: "Verifying...");
    final response = await _authRepository.verifyNid(
        shopId: DataHolder.shopId,
        nidNumber: nidNumber.value,
        nidFront: nidFront.value,
        nidBack: nidBack.value);
    CustomDialog.hideDialog();
    nidVerificationResponseModel.value = response;
    if (nidVerificationResponseModel.value.user.nidVerified == 1) {
      CustomDialog.showStringDialog("Nid Verification successful");
    } else {
      CustomDialog.showStringDialog("Nid Verification failed");
    }
  }
}
