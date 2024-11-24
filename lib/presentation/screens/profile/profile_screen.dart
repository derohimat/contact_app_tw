import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      child: Column(
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
          const SizedBox(height: 8.0),
          Text(
            "${controller.contact.firstName} ${controller.contact.lastName}",
            style: TextStyle(fontSize: 15.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            controller.contact.email.toString(),
            style: TextStyle(fontSize: 15.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            controller.contact.dob.toString(),
            style: TextStyle(fontSize: 15.0),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const ContactDetailScreen(),
                  arguments: controller.contact,
                  binding: ContactDetailBinding(),
                );
              },
              child: const Text('Update my detail'),
            ),
          ),
        ],
      ),
    );
  }
}
