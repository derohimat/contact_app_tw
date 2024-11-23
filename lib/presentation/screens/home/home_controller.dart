import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../../data/repositories/contact_repository.dart';

class HomeController extends GetxController {
  final ContactRepository _repository = ContactRepository();

  final isLoading = true.obs;
  final contacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    isLoading.value = true;
    try {
      final fetchedContacts = await _repository.getContacts();
      contacts.assignAll(fetchedContacts);
    } finally {
      isLoading.value = false;
    }
  }
}
