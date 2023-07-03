import 'package:flutter/material.dart';
import 'package:tailor_made/domain.dart';
import 'package:tailor_made/presentation/utils/route_transitions.dart';

import '../screens/contacts/contact.dart';
import '../screens/contacts/contacts.dart';
import '../screens/contacts/contacts_create.dart';
import '../screens/contacts/contacts_edit.dart';
import '../screens/contacts/widgets/contact_measure.dart';
import '../screens/jobs/widgets/contact_lists.dart';
import 'coordinator_base.dart';

@immutable
class ContactsCoordinator extends CoordinatorBase {
  const ContactsCoordinator(super.navigatorKey);

  void toContact(String id, {bool replace = false}) {
    replace
        ? navigator?.pushReplacement<dynamic, dynamic>(RouteTransitions.slideIn(ContactPage(id: id)))
        : navigator?.push<void>(RouteTransitions.slideIn(ContactPage(id: id)));
  }

  void toContactEdit(ContactEntity contact) {
    navigator?.push<void>(RouteTransitions.slideIn(ContactsEditPage(contact: contact)));
  }

  Future<Map<String, double>?>? toContactMeasure({
    required ContactEntity? contact,
    required Map<MeasureGroup, List<MeasureEntity>> grouped,
  }) {
    return navigator?.push<Map<String, double>>(
      RouteTransitions.slideIn(ContactMeasure(contact: contact, grouped: grouped)),
    );
  }

  void toContacts() {
    navigator?.push<void>(RouteTransitions.slideIn(const ContactsPage()));
  }

  Future<ContactEntity?>? toContactsList(List<ContactEntity> contacts) {
    return navigator?.push<ContactEntity>(RouteTransitions.fadeIn(ContactLists(contacts: contacts)));
  }

  void toCreateContact() {
    navigator?.push<void>(RouteTransitions.slideIn(const ContactsCreatePage()));
  }
}