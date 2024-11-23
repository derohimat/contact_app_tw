import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/contact.dart';

class ContactApiService {
  Future<List<Contact>> fetchContacts() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/data.json');
      final jsonData = jsonDecode(jsonString) as List;
      return jsonData.map((contactJson) => Contact.fromJson(contactJson)).toList();
    } catch (e) {
      // Handle error
      debugPrint('Error fetching contacts: $e');
      return [];
    }
  }
}
