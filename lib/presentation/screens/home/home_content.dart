import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../widgets/initial_avatar.dart';
import '../contact_detail/contact_binding.dart';
import '../contact_detail/contact_detail_screen.dart';
import 'home_controller.dart';

class HomeContent extends GetView<HomeController> {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.contacts.isEmpty) {
        return const Center(child: Text('No contacts found.'));
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchContacts();
          },
          child: ListView.builder(
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              final contact = controller.contacts[index];
              return ListTile(
                leading: InitialAvatar(
                  firstName: contact.firstName,
                  lastName: contact.lastName,
                ),
                title: Text('${contact.firstName} ${contact.lastName}'),
                onTap: () async {
                  final result = await Get.to(
                    () => const ContactDetailScreen(),
                    arguments: contact,
                    binding: ContactDetailBinding(),
                  );
                  if (result != null && result is Contact) {
                    controller.contacts[index] = result;
                  }
                },
              );
            },
          ),
        );
      }
    });
  }
}
