import 'package:shoppinglist_riverpod/models/item_model.dart';
import 'package:shoppinglist_riverpod/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems({required String userId});
  Future<String> createItem({required String userId, required Item item});
  Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItem({required String userId, required String itemId});
}

final itemRepositoryProvider =
    Provider<ItemRepository>((ref) => ItemRepository(ref.read));

class ItemRepository implements BaseItemRepository {
  final Reader _read;

  List<Item> itemList = <Item>[];

  ItemRepository(this._read);

  @override
  Future<List<Item>> retrieveItems({required String userId}) async {
    try {
      return itemList;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<String> createItem({
    required String userId,
    required Item item,
  }) async {
    try {
      //itemList.add(item);
      return item.name;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) async {
    try {
      itemList.removeWhere((element) => element.id == item.id);
      itemList.add(item);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> deleteItem({
    required String userId,
    required String itemId,
  }) async {
    try {
      itemList.removeWhere((element) => element.id == itemId);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
