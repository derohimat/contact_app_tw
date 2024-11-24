import 'package:get/get.dart';

import '../profile/profile_controller.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  final String loggedInUserId;

  HomeBinding(this.loggedInUserId);

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(loggedInUserId));
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
