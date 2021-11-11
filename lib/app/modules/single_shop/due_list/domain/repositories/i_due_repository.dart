import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/update_due_response_model.dart';

abstract class IDueRepository {
  Future<AddDueResponseModel> addDue({
    int userId,
    int shopId,
    num amount,
    int customerId,
    String customerMobile,
    String customerName,
    String customerAddress,
  });

  Future<GetAllDueResponseModel> getAllDue({int shopId});

  Future<UpdateDueResponseModel> updateDue({
    int shopId,
    int customerId,
    num dueLeft,
    String customerMobile,
  });
}
