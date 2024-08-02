import 'package:flutter/material.dart';
import 'package:item_tracker/feature/edit_item/edit_item.dart';
import 'package:item_tracker/viewmodel/createitemviewmodel.dart';
import 'package:item_tracker/widget/snackBar.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class ListOfItem extends StatefulWidget {
  const ListOfItem({super.key});

  @override
  State<ListOfItem> createState() => _ListOfItemState();
}

class _ListOfItemState extends State<ListOfItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'List Of Item',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.chevron_left_rounded)),
      ),
      body: Consumer<CreateItemViewModel>(
        builder: (context, value, child) {
          final itemData = value;
          return value.items.isEmpty
              ? const Center(
                  child: Text(
                    'Currently, no items found at the moment.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemData.items.length,
                  itemBuilder: (context, index) {
                    final item = itemData.items[index];
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  item.description,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                right: 20, top: 20, bottom: 20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return EditItem(
                                          itemName: item.name,
                                        );
                                      },
                                    ));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    context.loaderOverlay.show();
                                    await Future.delayed(
                                            const Duration(seconds: 2))
                                        .then((value) {
                                      context.loaderOverlay.hide();
                                      itemData.removeItem(item);
                                      showSuccessSnackBar(context,
                                          'Item ${item.name} deleted successfully.');
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
