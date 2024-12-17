part of 'contact_bloc.dart';


sealed class ContactState {}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactsLoaded extends ContactState {
  final List<Contact> contacts;

  ContactsLoaded(this.contacts);
}

final class ContactError extends ContactState {
  final String message;

  ContactError(this.message);
}

