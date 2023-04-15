import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ExploreWidget extends StatelessWidget {
  ExploreWidget({
    this.backdrop,
    this.label,
    this.page,
    super.key,
  });

  String? label;
  String? page;
  String? backdrop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.PERSON_PAGE);
      },
      child: Container(
        width: Get.width,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                Get.toNamed(page!);
              },
              child: Container(
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ]),
                ),
                height: 300,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("${backdrop}"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Text(
              "${label}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )
        ]),
      ),
    );
  }
}
