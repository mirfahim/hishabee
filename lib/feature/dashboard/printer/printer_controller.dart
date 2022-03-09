import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrinterController extends GetxController{
  final RxInt fontSize = 8.obs;
  final RxBool qrStore = false.obs;
  final RxString text = ''.obs;
}