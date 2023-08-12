import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalStorage<T> {
  Future<void> initLocalStorageHelper();

  Future<void> closeBox();

  Future<void> saveBox(T note);

  Box<T> getBox();

  List<T> getAllItems();

  List<T> searchItems(String query);

  Future<void> updateItem(T item);

  Future<void> deleteItem(String id);

  Future<void> updateListNote(List<T> items);
}
