part of 'contact_bloc.dart';


sealed class ContactEvent {}

final class LoadContacts extends ContactEvent {}

final class NewContactButtonPressed extends ContactEvent {}

final class AddContact extends ContactEvent {
  final Contact contact;

  AddContact(this.contact);
}

final class DeleteContact extends ContactEvent {
  final Contact contact;

  DeleteContact(this.contact);
}

final class UpdateContact extends ContactEvent {
  final Contact contact;

  UpdateContact(this.contact);
}
