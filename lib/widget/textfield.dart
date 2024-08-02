import 'package:flutter/material.dart';

Widget textFieldWidget(
    BuildContext context,
    TextEditingController textFieldController,
    String textFieldHintText,
    ValueChanged<String> textFieldCallBack) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    decoration: BoxDecoration(
        border: Border.all(), borderRadius: BorderRadius.circular(5)),
    child: TextField(
        onChanged: (value) {
          textFieldCallBack(value);
        },
        controller: textFieldController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            hintText: textFieldHintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none)),
  );
}
