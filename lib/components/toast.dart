import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String title, String description,
    ToastificationType type) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flat,
    title: Text(title),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    description: Text(description),
    autoCloseDuration: const Duration(seconds: 5),
  );
}
