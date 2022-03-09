import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/update_due_response_model.dart';

import '../../data/remote/models/add_due_item_request.dart';
import '../../data/remote/models/add_due_item_response.dart';
import '../../data/remote/models/add_due_request.dart';
import '../../data/remote/models/add_due_response.dart';
import '../../data/remote/models/get_all_due_item_by_uniq_id.dart';

abstract class IDueRepository {
  Future<AddDueResponseModel> addDue({
    int userId,
    int shopId,
    num amount,
    String image,
    int customerId,
    String customerMobile,
    String customerName,
    String customerAddress,
    String contactType,
    int version,
  });

  Future<GetAllDueResponseModel> getAllDue({int shopId});

  Future<UpdateDueResponseModel> updateDue({
    int shopId,
    int customerId,
    num dueLeft,
    String customerMobile,
  });
  Future<AddDueResponse> addNewDue(AddDueRequest addDueRequest);
  Future<AddDueItemResponse> addNewDueItem(AddDueItemRequest addDueItemRequest);
  Future<List<GetAllDueItemByUid>> getAllDueItemByUid({String uid});
}
