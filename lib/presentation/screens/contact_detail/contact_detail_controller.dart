import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../home/home_controller.dart';

class ContactDetailController extends GetxController {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController dobController;
  final contact = Get.arguments as Contact;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController(text: contact.firstName);
    lastNameController = TextEditingController(text: contact.lastName);
    emailController = TextEditingController(text: contact.email);
    dobController = TextEditingController(text: contact.dob);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }

  Future<void> updateContact(Contact updatedContact) async {
    try {
      // 1. Find the index of the contact to update
      final index = Get.find<HomeController>().contacts.indexWhere((contact) => contact.id == updatedContact.id);

      // 2. Update the contact in the list
      if (index != -1) {
        Get.find<HomeController>().contacts[index] = updatedContact;
      }
    } catch (e) {
      // Handle error
      debugPrint('Error updating contact: $e');
      Get.snackbar('Error', 'Failed to update contact', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
