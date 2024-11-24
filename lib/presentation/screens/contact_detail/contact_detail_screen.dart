import 'package:contact_app_tw/styles/app_colors.dart';
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
      appBar: AppBar(title: const Text('Contact Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: InitialAvatar(
                firstName: controller.contact.firstName,
                lastName: controller.contact.lastName,
                size: 100,
                textSize: 40,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Main Information",
              style: TextStyle(color: AppColors.blue, fontStyle: FontStyle.italic, fontSize: 15.0),
            ),
            Divider(),
            const SizedBox(height: 8.0),
            Text(
              "First Name",
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller.firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Last Name",
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller.lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.blue,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Sub Information",
              style: TextStyle(color: AppColors.blue, fontStyle: FontStyle.italic, fontSize: 15.0),
            ),
            Divider(),
            const SizedBox(height: 8.0),
            Text(
              "Email",
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.blue,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            Text(
              "Date of Birth",
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller.dobController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                prefixIcon: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.blue,
                ),
              ),
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
            const SizedBox(height: 16.0),
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
