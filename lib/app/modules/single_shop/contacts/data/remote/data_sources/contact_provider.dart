import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_list_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_list_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_list_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_response_model.dart';

abstract class IContactProvider {
  Future<List<Employee>> getAllEmployee({int shopId});

  Future<Employee> addNewEmployee({
    String name,
    int shopId,
    String position,
    String employeeId,
    String address,
    String mobile,
    String email,
    int monthlySalary,
    String imageSource,
  });

  Future<Employee> updateEmployee({
    int shopId,
    int id,
    String name,
    String employeeId,
    String position,
    String address,
    String mobile,
    String email,
    int monthlySalary,
    String imageSource,
  });

  Future<GenericResponseModel> deleteEmployee({
    int shopId,
    int id,
  });

  Future<List<Supplier>> getAllSupplier({int shopId});

  Future<Supplier> addNewSupplier({
    String name,
    int shopId,
    String address,
    String mobile,
    String email,
    String suppliedItems,
    String imageSource,
  });

  Future<Supplier> updateSupplier({
    int shopId,
    int id,
    String name,
    String address,
    String mobile,
    String email,
    String suppliedItems,
    String imageSource,
  });

  Future<GenericResponseModel> deleteSupplier({
    int shopId,
    int id,
  });

  Future<List<Customer>> getAllCustomer({int shopId});

  Future<Customer> addNewCustomer({
    String name,
    int shopId,
    String address,
    String mobile,
    String email,
    String imageSource,
  });

  Future<Customer> updateCustomer({
    int shopId,
    int id,
    String name,
    String address,
    String mobile,
    String email,
    String imageSource,
  });

  Future<GenericResponseModel> deleteCustomer({
    int shopId,
    int id,
  });
}

class ContactProvider extends GetConnect implements IContactProvider {
  final IAuthRepository authRepository;

  ContactProvider(this.authRepository);

  @override
  Future<Customer> addNewCustomer({
    String name,
    int shopId,
    String address,
    String mobile,
    String email,
    String imageSource,
  }) async {
    String url =
        "$BASE_URL/customer/add?name=$name&shop_id=$shopId&address=$address&email=$email&mobile=$mobile&image_src=$imageSource";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await post(
      url,
      {},
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return customerResponseModelFromJson(response.bodyString).customer;
  }

  @override
  Future<Employee> addNewEmployee({
    String name,
    int shopId,
    String position,
    String employeeId,
    String address,
    String mobile,
    String email,
    int monthlySalary,
    String imageSource,
  }) async {
    String url =
        "$BASE_URL/employee/add?name=$name&shop_id=$shopId&address=$address&position=$position&mobile=$mobile&monthly_salary=$monthlySalary&image_src=$imageSource";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await post(
      url,
      {},
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    final result = employeeResponseModelFromJson(response.bodyString);

    if (result.code == 200) {
      return result.employee;
    }

    return Future.error(result.message);
  }

  @override
  Future<Supplier> addNewSupplier({
    String name,
    int shopId,
    String address,
    String mobile,
    String email,
    String suppliedItems,
    String imageSource,
  }) async {
    String url =
        "$BASE_URL/supplier/add?name=$name&shop_id=$shopId&address=$address&email=$email&mobile=$mobile&supplied_items=$suppliedItems&image_src=$imageSource";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await post(
      url,
      {},
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return supplierResponseModelFromJson(response.bodyString).supplier;
  }

  @override
  Future<List<Employee>> getAllEmployee({int shopId}) async {
    String url = "$BASE_URL/employee/all?shop_id=$shopId";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await get(
      url,
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    print("my response is ${response.bodyString}");
    return getAllEmployeeResponseModelFromJson(response.bodyString);
  }

  @override
  Future<List<Customer>> getAllCustomer({int shopId}) async {
    String url = "$BASE_URL/customer/all?shop_id=$shopId";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await get(
      url,
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return getAllCustomerResponseModelFromJson(response.bodyString);
  }

  @override
  Future<List<Supplier>> getAllSupplier({int shopId}) async {
    String url = "$BASE_URL/supplier/all?shop_id=$shopId";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await get(
      url,
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return getAllSupplierResponseModelFromJson(response.bodyString);
  }

  @override
  Future<GenericResponseModel> deleteCustomer({int shopId, int id}) async {
    String url = "$BASE_URL/customer/delete?shop_id=$shopId&id=$id";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await delete(
      url,
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return genericResponseModelFromJson(response.bodyString);
  }

  @override
  Future<GenericResponseModel> deleteEmployee({int shopId, int id}) async {
    String url = "$BASE_URL/employee/delete?id=$id";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await delete(
      url,
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return genericResponseModelFromJson(response.bodyString);
  }

  @override
  Future<GenericResponseModel> deleteSupplier({int shopId, int id}) async {
    String url = "$BASE_URL/supplier/delete?shop_id=$shopId&id=$id";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await delete(
      url,
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return genericResponseModelFromJson(response.bodyString);
  }

  @override
  Future<Customer> updateCustomer({
    int shopId,
    int id,
    String name,
    String position,
    String address,
    String mobile,
    String email,
    String imageSource,
  }) async {
    String url =
        "$BASE_URL/customer/edit?name=$name&shop_id=$shopId&address=$address&mobile=$mobile&email=$email&image=$imageSource&id=$id";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await put(
      url,
      {},
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return customerResponseModelFromJson(response.bodyString).customer;
  }

  @override
  Future<Employee> updateEmployee({
    int shopId,
    int id,
    String name,
    String employeeId,
    String position,
    String address,
    String mobile,
    String email,
    int monthlySalary,
    String imageSource,
  }) async {
    String url =
        "$BASE_URL/employee/edit?name=$name&shop_id=$shopId&address=$address&position=$position&mobile=$mobile&email=$email&monthly_salary=$monthlySalary&image=$imageSource&id=$id&employee_id=$employeeId";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final response = await put(
      url,
      {},
      headers: headers,
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return employeeResponseModelFromJson(response.bodyString).employee;
  }

  @override
  Future<Supplier> updateSupplier({
    int shopId,
    int id,
    String name,
    String position,
    String address,
    String mobile,
    String email,
    String suppliedItems,
    String imageSource,
  }) async {
    String url =
        "$BASE_URL/supplier/edit?name=$name&shop_id=$shopId&address=$address&supplied_items=$suppliedItems&mobile=$mobile&email=$email&image_src=$imageSource&id=$id";

    final response = await put(
      url,
      {},
    );

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return supplierResponseModelFromJson(response.bodyString).supplier;
  }
}
