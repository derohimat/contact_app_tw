import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../../data/repositories/contact_repository.dart';

class ContactDetailController extends GetxController {
  final ContactRepository _repository = ContactRepository();
  final contact = Contact(id: '', firstName: '', lastName: '', email: '', dob: '', phone: '').obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final isEmailValid = true.obs;
  final isPhoneValid = true.obs;

  @override
  void onInit() {
    super.onInit();
    final Contact initialContact = Get.arguments;
    contact.value = initialContact;
    firstNameController.text = initialContact.firstName;
    lastNameController.text = initialContact.lastName;
    emailController.text = initialContact.email;
    phoneController.text = initialContact.phone;
    dobController.text = initialContact.dob;
  }

  void validateEmail(String email) {
    isEmailValid.value = email.contains('@') && email.contains('.com');
  }

  void validatePhone(String phone) {
    isPhoneValid.value = phone.length >= 10;
  }

  bool validateForm() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        (emailController.text.isEmpty || isEmailValid.value) &&
        (phoneController.text.isEmpty || isPhoneValid.value);
  }

  Future<void> saveContact(Contact contact) async {
    if (contact.id.isEmpty) {
      await _repository.addContact(contact);
    } else {
      await _repository.updateContact(contact);
    }
  }

  Future<void> removeContact() async {
    await _repository.removeContact(contact.value.id);
  }
}
