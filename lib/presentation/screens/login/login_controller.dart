import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../../data/repositories/contact_repository.dart';
import '../../../data/services/secure_storage_service.dart';
import '../home/home_screen.dart';

class LoginController extends GetxController {
  final idController = TextEditingController();
  var contacts = <Contact>[].obs;
  final ContactRepository _repository = ContactRepository();

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  Future<void> login() async {
    final enteredId = idController.text;

    Contact? loggedInUser = contacts.firstWhereOrNull((contact) => contact.id == enteredId);

    if (loggedInUser != null) {
      // Store the logged-in user's ID using SecureStorageService
      await SecureStorageService.setLoggedInUserId(loggedInUser.id);

      Get.offAll(() => const HomeScreen());
    } else {
      Get.snackbar('Error', 'Invalid ID', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> loadContacts() async {
    try {
      List<Contact> fetchedContacts = await _repository.getContacts();
      contacts.assignAll(fetchedContacts);
    } catch (e) {
      debugPrint('Error loading contacts: $e');
    }
  }
}
