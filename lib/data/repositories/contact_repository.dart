import '../models/contact.dart';
import '../services/contact_api_service.dart';

class ContactRepository {
  final ContactApiService _service = ContactApiService();

  Future<List<Contact>> getContacts() async {
    return await _service.fetchContacts();
  }

  Future<void> addContact(Contact newContact) async {
    await _service.addContact(newContact);
  }

  Future<void> updateContact(Contact updatedContact) async {
    await _service.updateContact(updatedContact);
  }

  Future<void> removeContact(String contactId) async {
    await _service.removeContact(contactId);
  }
}
