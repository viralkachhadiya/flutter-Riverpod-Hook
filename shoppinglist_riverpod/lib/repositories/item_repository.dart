import 'package:shoppinglist_riverpod/general_providers.dart';
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

  const ItemRepository(this._read);

  @override
  Future<List<Item>> retrieveItems({required String userId}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).usersListRef(userId).get();
      return snap.docs.map((doc) => Item.fromDocument(doc)).toList();
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
      final docRef = await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .add(item.toDocument());
      return docRef.id;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .doc(item.id)
          .update(item.toDocument());
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
      await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .doc(itemId)
          .delete();
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
