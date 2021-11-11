import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';

abstract class IContactRepository {
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

  Future<void> clearDatabase();
}
