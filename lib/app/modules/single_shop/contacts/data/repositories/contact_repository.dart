import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';

class ContactRepository implements IContactRepository {
  final IContactProvider contactProvider;
  final ILocalContactProvider localContactProvider;
  final INetworkInfo networkInfo;

  ContactRepository(
      this.contactProvider, this.localContactProvider, this.networkInfo);

  @override
  Future<Customer> addNewCustomer({
    String name,
    int shopId,
    String address,
    String mobile,
    String email,
    String imageSource,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.addNewCustomer(
            name: name,
            shopId: shopId,
            address: address,
            mobile: mobile,
            email: email,
            imageSource: imageSource);
        return response;
      } catch (e) {
        return Future.error(e.toString());
      }
    } else {
      final customer = Customer(
          name: name,
          shopId: shopId,
          address: address,
          mobile: mobile,
          email: email,
          imageSrc: imageSource);

      localContactProvider.saveCustomer(customer, true);

      return customer;
    }
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
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.addNewEmployee(
            name: name,
            shopId: shopId,
            position: position,
            employeeId: employeeId,
            address: address,
            mobile: mobile,
            email: email,
            monthlySalary: monthlySalary,
            imageSource: imageSource);
        return response;
      } catch (e) {
        return Future.error(e);
      }
    }
    return Future.error("Network error");
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
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.addNewSupplier(
            name: name,
            shopId: shopId,
            address: address,
            mobile: mobile,
            email: email,
            suppliedItems: suppliedItems,
            imageSource: imageSource);
        return response;
      } catch (e) {
        return Future.error(e);
      }
    }
    return Future.error("Network error");
  }

  @override
  Future<GenericResponseModel> deleteCustomer({int shopId, int id}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response =
            await contactProvider.deleteCustomer(shopId: shopId, id: id);
        return response;
      } catch (e) {
        return Future.error(e);
      }
    }
    return Future.error("Network error");
  }

  @override
  Future<GenericResponseModel> deleteEmployee({int shopId, int id}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response =
            await contactProvider.deleteCustomer(shopId: shopId, id: id);

        return response;
      } catch (e) {
        return Future.error(e);
      }
    }
    return Future.error("Network error");
  }

  @override
  Future<GenericResponseModel> deleteSupplier({int shopId, int id}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response =
            await contactProvider.deleteCustomer(shopId: shopId, id: id);

        return response;
      } catch (e) {
        return Future.error(e);
      }
    }
    return Future.error("Network error");
  }

  @override
  Future<List<Employee>> getAllEmployee({int shopId}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.getAllEmployee(shopId: shopId);

        await localContactProvider.saveAllEmployee(shopId, response);
        return response;
      } catch (e) {
        return Future.error(e);
      }
    } else {
      try {
        final result = await localContactProvider.getAllEmployee(shopId);
        return result;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<List<Customer>> getAllCustomer({int shopId}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.getAllCustomer(shopId: shopId);

        localContactProvider.saveAllCustomer(shopId, response);
        return response;
      } catch (e) {
        return Future.error(e);
      }
    } else {
      try {
        final result = await localContactProvider.getAllCustomer(shopId);
        return result;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<List<Supplier>> getAllSupplier({int shopId}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.getAllSupplier(shopId: shopId);
        await localContactProvider.saveAllSupplier(shopId, response);
        return response;
      } catch (e) {
        return Future.error(e);
      }
    } else {
      try {
        final result = await localContactProvider.getAllSupplier(shopId);
        return result;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<Customer> updateCustomer({
    int shopId,
    int id,
    String name,
    String address,
    String mobile,
    String email,
    String imageSource,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.updateCustomer(
            shopId: shopId,
            id: id,
            name: name,
            address: address,
            mobile: mobile,
            email: email,
            imageSource: imageSource);

        return response;
      } catch (e) {
        return Future.error(e);
      }
    }

    return Future.error("Network error");
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
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.updateEmployee(
            shopId: shopId,
            id: id,
            name: name,
            employeeId: employeeId,
            position: position,
            address: address,
            mobile: mobile,
            email: email,
            monthlySalary: monthlySalary,
            imageSource: imageSource);

        return response;
      } catch (e) {
        print(e);
        return Future.error(e);
      }
    }

    return Future.error("Network error");
  }

  @override
  Future<Supplier> updateSupplier({
    int shopId,
    int id,
    String name,
    String address,
    String mobile,
    String email,
    String suppliedItems,
    String imageSource,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await contactProvider.updateSupplier(
            shopId: shopId,
            id: id,
            name: name,
            address: address,
            mobile: mobile,
            email: email,
            suppliedItems: suppliedItems,
            imageSource: imageSource);

        return response;
      } catch (e) {
        return Future.error(e);
      }
    }

    return Future.error("Network error");
  }

  @override
  Future<void> clearDatabase() async {
    await localContactProvider.clearDatabase();
  }
}
