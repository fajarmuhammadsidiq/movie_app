import 'package:flutter/material.dart';
import 'package:get/get.dart';

class buttonWidget extends StatelessWidget {
  buttonWidget({
    required this.icon,
    required this.name,
    this.onpressed,
    super.key,
  });
  final name;
  Icon icon;
  final onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
        onPressed: () {
          Get.toNamed(onpressed);
        },
        icon: icon,
        label: Text(
          name,
          style: const TextStyle(color: Colors.black),
        ));
  }
}
