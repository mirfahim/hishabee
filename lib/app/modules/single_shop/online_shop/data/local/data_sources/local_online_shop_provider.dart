import 'package:hive/hive.dart';

abstract class ILocalOnlineShopProvider {
  Future<void> addDeliveryCompanyUrl(int shopId, String value);

  Future<List<String>> getDeliveryCompanyUrls(int shopId);
}

class LocalOnlineShopProvider implements ILocalOnlineShopProvider {
  final String boxKey = 'onlineShopBox';
  final String deliveryCompanyUrlKey = 'deliveryCompanyUrl';

  @override
  Future<void> addDeliveryCompanyUrl(int shopId, String value) async {
    List<String> urls = [];

    final res = await getDeliveryCompanyUrls(shopId);

    urls.addAll(res);

    urls.add(value);

    final onlineShopBox = await Hive.openBox(boxKey);

    return await onlineShopBox.put(
        deliveryCompanyUrlKey + shopId.toString(), urls);
  }

  @override
  Future<List<String>> getDeliveryCompanyUrls(int shopId) async {
    final onlineShopBox = await Hive.openBox(boxKey);

    return await onlineShopBox.get(deliveryCompanyUrlKey + shopId.toString()) ??
        [];
  }
}
