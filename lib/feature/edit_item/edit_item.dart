import 'package:flutter/material.dart';
import 'package:item_tracker/model/item.dart';
import 'package:item_tracker/viewmodel/createitemviewmodel.dart';
import 'package:item_tracker/widget/button.dart';
import 'package:item_tracker/widget/snackBar.dart';
import 'package:item_tracker/widget/textfield.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class EditItem extends StatefulWidget {
  String itemName;
  EditItem({super.key, required this.itemName});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController itemEditNameController = TextEditingController();
  TextEditingController itemEditDescriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final selectedItemData =
        context.read<CreateItemViewModel>().items.firstWhere(
              (element) => element.name == widget.itemName,
            );
    setState(() {
      itemEditNameController.text = selectedItemData.name;
      itemEditDescriptionController.text = selectedItemData.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Edit Item',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.chevron_left_rounded)),
      ),
      body: Consumer<CreateItemViewModel>(
        builder: (context, itemProvider, child) {
          return Column(
            children: [
              textFieldWidget(context, itemEditNameController,
                  'Enter Item Name', (value) {}),
              textFieldWidget(context, itemEditDescriptionController,
                  'Enter Item Description', (value) {}),
              buttonWidget(context, 'Save', () async {
                FocusScope.of(context).unfocus();
                context.loaderOverlay.show();
                if (itemEditNameController.text == "") {
                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) {
                    context.loaderOverlay.hide();
                    showErrorSnackBar(context, 'Item Name Cannot Be Empty');
                  });

                  return;
                }
                if (itemEditDescriptionController.text == "") {
                  await Future.delayed(const Duration(seconds: 2))
                      .then((value) {
                    context.loaderOverlay.hide();
                    showErrorSnackBar(
                        context, 'Item Description Cannot Be Empty');
                  });
                  return;
                }
                await Future.delayed(const Duration(seconds: 2)).then((value) {
                  context.loaderOverlay.hide();
                  itemProvider.updateItem(
                      Item(
                          name: itemEditNameController.text,
                          description: itemEditDescriptionController.text),
                      widget.itemName);
                  showSuccessSnackBar(context, 'Item Updated Successfully.');
                });
              })
            ],
          );
        },
      ),
    );
  }
}
