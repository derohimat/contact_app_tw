import '../models/contact.dart';
import '../services/contact_api_service.dart';

class ContactRepository {
  final ContactApiService _apiService = ContactApiService();

  Future<List<Contact>> getContacts() async {
    return await _apiService.fetchContacts();
  }
}
