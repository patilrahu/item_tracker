import 'package:flutter/material.dart';
import 'package:item_tracker/model/item.dart';

class CreateItemViewModel with ChangeNotifier {
  List<Item> itemAddData = [];
  List<Item> get items => itemAddData;

  void createItem(Item itemData) {
    itemAddData.add(itemData);
    notifyListeners();
  }

  void removeItem(Item itemData) {
    itemAddData.remove(itemData);
    notifyListeners();
  }

  void updateItem(Item newItemData, String oldItemName) {
    final updateItem = itemAddData.indexWhere(
      (element) => element.name == oldItemName,
    );
    itemAddData[updateItem] = newItemData;
    notifyListeners();
  }
}
