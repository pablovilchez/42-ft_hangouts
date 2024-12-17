import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/di/dependency_injection.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/delete_contact_usecase.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:ft_hangouts/features/contacts/domain/usecases/update_contact_usecase.dart';

import '../../data/models/contact_model.dart';
import '../../domain/entities/contact.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final getContactsUseCase = getIt<GetContactsUseCase>();
  final addContactUseCase = getIt<AddContactUseCase>();
  final deleteContactUseCase = getIt<DeleteContactUseCase>();
  final updateContactUseCase = getIt<UpdateContactUseCase>();

  ContactBloc() : super(ContactInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);

    add(LoadContacts());
  }

  Future<void> _onLoadContacts(
      LoadContacts event, Emitter<ContactState> emit) async {
    try {
      final contacts = await getContactsUseCase();
      emit(ContactsLoaded(contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onAddContact(
      AddContact event, Emitter<ContactState> emit) async {
    try {
      final newContactModel = ContactModel.fromEntity(event.contact);
      await addContactUseCase(newContactModel);

      final updatedContacts = await getContactsUseCase();
      emit(ContactsLoaded(updatedContacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onDeleteContact(
      DeleteContact event, Emitter<ContactState> emit) async {
    try {
      await deleteContactUseCase(event.contact);

      final updatedContacts = await getContactsUseCase();
      emit(ContactsLoaded(updatedContacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onUpdateContact(
      UpdateContact event, Emitter<ContactState> emit) async {
    try {
      final updatedContactModel = ContactModel.fromEntity(event.contact);
      await updateContactUseCase(updatedContactModel);

      final updatedContacts = await getContactsUseCase();
      emit(ContactsLoaded(updatedContacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
