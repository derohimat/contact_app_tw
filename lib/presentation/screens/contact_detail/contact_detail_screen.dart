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
    final bool isAddContactMode = controller.contact.value.id.isEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Contact Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Obx(() {
                final contact = controller.contact.value;
                return InitialAvatar(
                  firstName: contact.firstName,
                  lastName: contact.lastName,
                  size: 100,
                  textSize: 40,
                  isAddContactMode: isAddContactMode,
                );
              }),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Main Information",
              style: TextStyle(color: AppColors.blue, fontStyle: FontStyle.italic, fontSize: 15.0),
            ),
            Divider(),
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                text: 'First Name',
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
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
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                text: 'Last Name',
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
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
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                controller.validateEmail(value);
              },
            ),
            Obx(() {
              return controller.isEmailValid.value
                  ? const SizedBox.shrink()
                  : const Text(
                      'Invalid email format',
                      style: TextStyle(color: Colors.red),
                    );
            }),
            const SizedBox(height: 16.0),
            Text(
              "Phone",
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller.phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(
                  Icons.phone,
                  color: AppColors.blue,
                ),
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                controller.validatePhone(value);
              },
            ),
            Obx(() {
              return controller.isPhoneValid.value
                  ? const SizedBox.shrink()
                  : const Text(
                      'Invalid phone number',
                      style: TextStyle(color: Colors.red),
                    );
            }),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.validateForm()) {
                    final newContact = Contact(
                      id: controller.contact.value.id,
                      firstName: controller.firstNameController.text,
                      lastName: controller.lastNameController.text,
                      email: controller.emailController.text,
                      dob: controller.dobController.text,
                      phone: controller.phoneController.text,
                    );
                    await controller.saveContact(newContact);
                    Get.back(result: newContact);
                  }
                },
                child: Text(isAddContactMode ? 'Save' : 'Update'),
              ),
            ),
            if (!isAddContactMode) ...[
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    controller.removeContact();
                    Get.back(result: 'removed');
                  },
                  child: const Text('Remove'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
