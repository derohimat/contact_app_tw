import 'package:get/get.dart';

import '../../../data/models/contact.dart';

class ProfileController extends GetxController {
  late Contact contact;

  void updateProfileData({
    required Contact contact,
  }) {
    this.contact = contact;
  }
}
