import 'package:get/get.dart';

import '../../../data/models/contact.dart';

class ProfileController extends GetxController {
  var contact = Contact(id: '', firstName: '', lastName: '', email: '', dob: '').obs;

  void updateProfileData({
    required Contact newContact,
  }) {
    contact.value = newContact;
  }
}