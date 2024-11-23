import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.contacts.isEmpty) {
          return const Center(child: Text('No contacts found.'));
        } else {
          return ListView.builder(
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              final contact = controller.contacts[index];
              return ListTile(
                title: Text('${contact.firstName} ${contact.lastName}'),
              );
            },
          );
        }
      }),
    );
  }
}
