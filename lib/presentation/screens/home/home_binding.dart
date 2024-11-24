import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  final String loggedInUserId;

  HomeBinding(this.loggedInUserId);

  @override
  void dependencies() {
    Get.put(HomeController(loggedInUserId));
  }
}
