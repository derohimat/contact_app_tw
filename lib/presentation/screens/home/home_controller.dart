import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../../data/repositories/contact_repository.dart';

class HomeController extends GetxController {
  final ContactRepository _repository = ContactRepository();
  final isLoading = true.obs;
  final contacts = <Contact>[].obs;
  final String loggedInUserId;

  HomeController(this.loggedInUserId);

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    isLoading.value = true;
    try {
      final fetchedContacts = await _repository.getContacts();
      fetchedContacts.sort((a, b) => a.firstName.compareTo(b.firstName));
      contacts.assignAll(fetchedContacts);
    } finally {
      isLoading.value = false;
    }
  }

  Contact? get loggedInUser {
    return contacts.firstWhereOrNull((contact) => contact.id == loggedInUserId);
  }
}
