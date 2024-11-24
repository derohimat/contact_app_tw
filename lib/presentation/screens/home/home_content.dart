import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/contact.dart';
import '../../../styles/app_colors.dart';
import '../../widgets/initial_avatar.dart';
import '../contact_detail/contact_binding.dart';
import '../contact_detail/contact_detail_screen.dart';
import 'home_controller.dart';

class HomeContent extends GetView<HomeController> {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final RxString searchQuery = ''.obs;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search your contacts list',
              hintStyle: TextStyle(color: AppColors.darkGray),
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              searchQuery.value = value;
            },
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.contacts.isEmpty) {
              return const Center(child: Text('No contacts found.'));
            } else {
              final filteredContacts = controller.contacts.where((contact) {
                final query = searchQuery.value.toLowerCase();
                return contact.firstName.toLowerCase().contains(query) || contact.lastName.toLowerCase().contains(query);
              }).toList();
              final groupedContacts = _groupContactsByFirstChar(filteredContacts);
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchContacts();
                },
                child: ListView.builder(
                  itemCount: groupedContacts.length,
                  itemBuilder: (context, index) {
                    final group = groupedContacts.entries.elementAt(index);
                    return _buildGroup(context, group.key, group.value);
                  },
                ),
              );
            }
          }),
        ),
      ],
    );
  }

  Map<String, List<Contact>> _groupContactsByFirstChar(List<Contact> contacts) {
    final Map<String, List<Contact>> groupedContacts = {};
    for (var contact in contacts) {
      final firstChar = contact.firstName[0].toUpperCase();
      if (!groupedContacts.containsKey(firstChar)) {
        groupedContacts[firstChar] = [];
      }
      groupedContacts[firstChar]!.add(contact);
    }
    return groupedContacts;
  }

  Widget _buildGroup(BuildContext context, String groupKey, List<Contact> contacts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupKey,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                  ),
                ),
                const Divider(color: AppColors.darkGray),
              ],
            )),
        ...contacts.map(
          (contact) => ListTile(
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
                final index = controller.contacts.indexOf(contact);
                controller.contacts[index] = result;
              }
            },
          ),
        ),
      ],
    );
  }
}
