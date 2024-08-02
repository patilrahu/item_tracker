import 'package:flutter/material.dart';
import 'package:item_tracker/feature/item_list/item_list.dart';
import 'package:item_tracker/model/item.dart';
import 'package:item_tracker/viewmodel/createitemviewmodel.dart';
import 'package:item_tracker/widget/button.dart';
import 'package:item_tracker/widget/snackBar.dart';
import 'package:item_tracker/widget/textfield.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({super.key});

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createItemViewModel = Provider.of<CreateItemViewModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            title: const Text(
              'Welcome To Item Tracker',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.purpleAccent),
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Create An Item'.toUpperCase(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            textFieldWidget(
                context, itemNameController, 'Enter Item Name', (value) {}),
            textFieldWidget(context, itemDescriptionController,
                'Enter Item Description', (value) {}),
            buttonWidget(context, 'Create Item', () async {
              FocusScope.of(context).unfocus();
              context.loaderOverlay.show();
              if (itemNameController.text == "") {
                await Future.delayed(const Duration(seconds: 2)).then((value) {
                  context.loaderOverlay.hide();
                  showErrorSnackBar(context, 'Item Name Cannot Be Empty');
                });

                return;
              }
              if (itemDescriptionController.text == "") {
                await Future.delayed(const Duration(seconds: 2)).then((value) {
                  context.loaderOverlay.hide();
                  showErrorSnackBar(
                      context, 'Item Description Cannot Be Empty');
                });
                return;
              }

              await Future.delayed(const Duration(seconds: 2)).then((value) {
                context.loaderOverlay.hide();
                createItemViewModel.createItem(Item(
                    name: itemNameController.text,
                    description: itemDescriptionController.text));
                itemDescriptionController.clear();
                itemNameController.clear();
                showSuccessSnackBar(context, 'Item Created Successfully');
              });
            }),
            buttonWidget(context, 'List Of Item', () {
              FocusScope.of(context).unfocus();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ListOfItem();
                },
              ));
            })
          ]),
        ),
      ),
    );
  }
}
