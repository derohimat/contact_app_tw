import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../widgets/initial_avatar.dart';
import 'contact_detail_controller.dart';

class ContactDetailScreen extends GetView<ContactDetailController> {
  const ContactDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InitialAvatar(
              firstName: controller.contact.firstName,
              lastName: controller.contact.lastName,
              size: 100.0,
              textSize: 40.0,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: controller.lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: controller.dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth'),
              onTap: () async {
                // Show date picker
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controller.dobController.text = pickedDate.toString();
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Update contact
                await controller.updateContact(
                  Contact(
                    id: controller.contact.id,
                    firstName: controller.firstNameController.text,
                    lastName: controller.lastNameController.text,
                    email: controller.emailController.text,
                    dob: controller.dobController.text,
                  ),
                );

                // Go back to the previous screen
                Get.back();
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Remove contact
                // Get.back(result: 'remove');
              },
              child: const Text('Remove'),
            ),
          ],
        ),
      ),
    );
  }
}
