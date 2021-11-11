import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/salary_response_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalSalaryProvider {
  Future<List<SalaryResponseModel>> getAllSalary(int shopId);

  Future<void> saveAllSalary(int shopId, List<SalaryResponseModel> salaries);

  Future<void> clearDatabase();
}

class LocalSalaryProvider implements ILocalSalaryProvider {
  final String boxKey = 'salaryBox';
  final String salariesKey = 'salaries';

  @override
  Future<List<SalaryResponseModel>> getAllSalary(int shopId) async {
    final salaryBox = await Hive.openBox(boxKey);

    final salaries = salaryBox.get(salariesKey + shopId.toString());

    if (salaries != null) {
      return Future.value(salaryResponseModelFromJson(jsonDecode(salaries)));
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<void> saveAllSalary(
      int shopId, List<SalaryResponseModel> salaries) async {
    final salaryBox = await Hive.openBox(boxKey);
    return await salaryBox.put(
        salariesKey + shopId.toString(), salaryResponseModelToJson(salaries));
  }

  @override
  Future<void> clearDatabase() async {
    final salaryBox = await Hive.openBox(boxKey);

    return salaryBox.clear();
  }
}
