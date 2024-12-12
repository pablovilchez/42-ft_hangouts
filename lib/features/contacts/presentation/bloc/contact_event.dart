part of 'contact_bloc.dart';

@immutable
sealed class ContactEvent {}

final class LoadContacts extends ContactEvent {}

final class NewContactButtonPressed extends ContactEvent {}

final class AddContact extends ContactEvent {
  final Contact contact;

  AddContact(this.contact);
}
