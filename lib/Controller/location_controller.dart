import 'package:get/get.dart';

class LocationController extends GetxController{
  // ignore: prefer_typing_uninitialized_variables
  var selectedValue;
  void setSelected(String value){
    selectedValue = value;
    update();
  }
  List<String> gender = [
    "FEMALE",
    "MALE",
    "OTHER",
  ];
}