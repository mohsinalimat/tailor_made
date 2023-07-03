import 'package:flutter/material.dart';
import 'package:tailor_made/domain.dart';
import 'package:tailor_made/presentation/widgets.dart';

import '../../contacts/widgets/contacts_list_item.dart';

class ContactLists extends StatelessWidget {
  const ContactLists({super.key, required this.contacts});

  final List<ContactEntity> contacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Text('Select Client')),
      body: contacts.isEmpty
          ? const Center(child: EmptyResultView(message: 'No contacts available'))
          : ListView.separated(
              itemCount: contacts.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final ContactEntity item = contacts[index];
                return ContactsListItem(
                  contact: item,
                  showActions: false,
                  onTapContact: () => Navigator.pop(context, item),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
    );
  }
}