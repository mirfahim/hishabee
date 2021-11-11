import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

abstract class ILocalContactProvider {
  Future<List<Employee>> getAllEmployee(int shopId);

  Future<void> saveAllEmployee(int shopId, List<Employee> employees);

  Future<List<Customer>> getAllCustomer(int shopId);

  Future<void> saveAllCustomer(int shopId, List<Customer> customers);

  Future<List<Supplier>> getAllSupplier(int shopId);

  Future<void> saveAllSupplier(int shopId, List<Supplier> suppliers);

  Future<void> saveCustomer(Customer customer, bool isLocal);

  Future<void> clearDatabase();
}

class LocalContactProvider implements ILocalContactProvider {
  final String boxKey = 'contactBox';
  final String employeeKey = 'employee';
  final String customerKey = 'customer';
  final String supplierKey = 'supplier';

  @override
  Future<List<Customer>> getAllCustomer(int shopId) async {
    final contactBox = await Hive.openBox(boxKey);

    final customers = contactBox.get(customerKey + shopId.toString());

    if (customers != null) {
      return customerFromJson(jsonDecode(customers));
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<List<Employee>> getAllEmployee(int shopId) async {
    final contactBox = await Hive.openBox(boxKey);

    final employees = contactBox.get(employeeKey + shopId.toString());

    if (employees != null) {
      return Future.value(employeeFromJson(jsonDecode(employees)));
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<List<Supplier>> getAllSupplier(int shopId) async {
    final contactBox = await Hive.openBox(boxKey);

    final suppliers = contactBox.get(supplierKey + shopId.toString());

    if (suppliers != null) {
      return Future.value(supplierFromJson(jsonDecode(suppliers)));
    } else {
      return Future.error("Catch error!");
    }
  }

  @override
  Future<void> saveAllCustomer(int shopId, List<Customer> customers) async {
    final contactBox = await Hive.openBox(boxKey);

    return await contactBox.put(
        customerKey + shopId.toString(), customerToJson(customers));
  }

  @override
  Future<void> saveAllEmployee(int shopId, List<Employee> employees) async {
    final contactBox = await Hive.openBox(boxKey);

    return await contactBox.put(
        employeeKey + shopId.toString(), employeeToJson(employees));
  }

  @override
  Future<void> saveAllSupplier(int shopId, List<Supplier> suppliers) async {
    final contactBox = await Hive.openBox(boxKey);

    return await contactBox.put(
        supplierKey + shopId.toString(), supplierToJson(suppliers));
  }

  @override
  Future<void> clearDatabase() async {
    final contactBox = await Hive.openBox(boxKey);

    contactBox.clear();
  }

  @override
  Future<void> saveCustomer(Customer customer, bool isLocal) async {
    final contactBox = await Hive.openBox(boxKey);
    final uuid = Uuid();

    final key = uuid.v4();

    print('UUID Key: $key');

    final contactMap = {'customer': customer.toJson(), 'isLocal': isLocal};

    return contactBox.put(key, contactMap);
  }
}
