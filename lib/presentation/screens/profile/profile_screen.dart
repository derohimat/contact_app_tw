import 'package:contact_app_tw/utils/date_format_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../widgets/initial_avatar.dart';
import '../contact_detail/contact_binding.dart';
import '../contact_detail/contact_detail_screen.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final contact = controller.contact.value;
        return Column(
          children: [
            Center(
              child: InitialAvatar(
                firstName: contact.firstName,
                lastName: contact.lastName,
                size: 100,
                textSize: 40,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "${contact.firstName} ${contact.lastName}",
              style: TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              contact.email.isEmpty ? '-' : contact.email,
              style: TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              contact.phone.isEmpty ? '-' : contact.phone,
              style: TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              contact.dob.isEmpty ? '-' : DateFormatUtil.format(DateFormatUtil.parse(contact.dob) ?? DateTime.now()),
              style: TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Get.to(
                    () => const ContactDetailScreen(),
                    arguments: contact,
                    binding: ContactDetailBinding(),
                  );
                  if (result != null && result is Contact) {
                    controller.updateProfileData(newContact: result);
                  }
                },
                child: const Text('Update my detail'),
              ),
            ),
          ],
        );
      }),
    );
  }
}
