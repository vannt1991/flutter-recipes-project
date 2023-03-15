import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loading_controller.dart';

class LoadingView extends GetView<LoadingController> {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.adb,
                size: 55,
                color: Colors.black,
              )).paddingOnly(top: Get.mediaQuery.size.height * 0.4),
          const Spacer(),
          const Text(
            'LOADING...',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ).paddingOnly(bottom: 20.0)
        ],
      ),
    );
  }
}
