import 'package:get/get.dart';

class ProfileController extends GetxController {
  final userName = ''.obs;
  final userEmail = ''.obs;

  void updateProfileData({
    required String name,
    required String email,
  }) {
    userName.value = name;
    userEmail.value = email;
  }
}
