import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
      message,
      style: const TextStyle(
          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
    )),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.red),
  );
}
