import 'package:flutter/material.dart';

Widget buttonWidget(
    BuildContext context, String buttonTitle, VoidCallback buttonPressed) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
        onPressed: buttonPressed,
        child: Text(
          buttonTitle,
          style: const TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
        )),
  );
}
