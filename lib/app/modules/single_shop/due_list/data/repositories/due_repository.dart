import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/data_sources/due_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_item_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_item_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response_model.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_unuque_id.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/update_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/domain/repositories/i_due_repository.dart';

import '../remote/models/get_all_due_item_by_uniq_id.dart';

class DueRepository implements IDueRepository {
  final IDueProvider dueProvider;

  DueRepository(this.dueProvider);

  @override
  Future<AddDueResponseModel> addDue({
    int userId,
    int shopId,
    num amount,
    int customerId,
    String customerMobile,
    String customerName,
    String customerAddress,
  }) async {
    final response = await dueProvider.addDue(
      userId: userId,
      shopId: shopId,
      amount: amount,
      customerId: customerId,
      customerMobile: customerMobile,
      customerName: customerName,
      customerAddress: customerAddress,
    );

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GetAllDueResponseModel> getAllDue({int shopId}) async {
    final response = await dueProvider.getAllDue(shopId: shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<UpdateDueResponseModel> updateDue(
      {int shopId, int customerId, num dueLeft, String customerMobile}) async {
    final response = await dueProvider.updateDue(
        shopId: shopId,
        customerId: customerId,
        dueLeft: dueLeft,
        customerMobile: customerMobile);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<AddDueResponse> addNewDue(AddDueRequest addDueRequest) async{
    final response = await dueProvider.addNewDue(addDueRequest);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<AddDueItemResponse> addNewDueItem(AddDueItemRequest addDueItemRequest) async{
    final response = await dueProvider.addNewDueItem(addDueItemRequest);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<GetAllDueItemByUid>> getAllDueItemByUid({String uid}) async{
    final response = await dueProvider.getAllDueItemByUid(uid: uid);
    return ResponseDecoder.decode(response);
  }
}
