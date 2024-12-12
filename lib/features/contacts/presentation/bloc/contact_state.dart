part of 'contact_bloc.dart';

@immutable
sealed class ContactState {}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactLoaded extends ContactState {
  final List<Contact> contacts;

  ContactLoaded(this.contacts);
}

final class ContactError extends ContactState {
  final String message;

  ContactError(this.message);
}

