import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Upcoming'),
    Tab(text: 'Past'),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
