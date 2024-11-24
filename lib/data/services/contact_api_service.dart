import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/contact.dart';

class ContactApiService {
  final List<Contact> _contacts = [];

  Future<List<Contact>> fetchContacts() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/data.json');
      final jsonData = jsonDecode(jsonString) as List;
      _contacts.clear();
      _contacts.addAll(jsonData.map((contactJson) => Contact.fromJson(contactJson)).toList());
      return _contacts;
    } catch (e) {
      // Handle error
      debugPrint('Error fetching contacts: $e');
      return [];
    }
  }

  Future<void> updateContact(Contact updatedContact) async {
    final index = _contacts.indexWhere((contact) => contact.id == updatedContact.id);
    if (index != -1) {
      _contacts[index] = updatedContact;
    }
  }

  Future<void> removeContact(String contactId) async {
    _contacts.removeWhere((contact) => contact.id == contactId);
  }
}
