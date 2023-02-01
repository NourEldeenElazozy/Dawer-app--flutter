import 'package:get/get.dart';

class SelectionController extends GetxController{
  var male = false.obs;
  var female = false.obs;
  var yes = false.obs;
  var no = false.obs;
  var yes1 = false.obs;
  var no1 = false.obs;
  var morning = false.obs;
  var evening = false.obs;
  var yesButton = false.obs;
  var noButton = false.obs;
  // ignore: prefer_typing_uninitialized_variables
  var time;
  onIndexChange(index) {
    time = index;
    update();
  }

  // ignore: prefer_typing_uninitialized_variables
  var feesInformation;
  onIndexChangeFees(index) {
    feesInformation = index;
    update();
  }
}