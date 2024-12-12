import 'package:bloc/bloc.dart';
import 'package:ft_hangouts/features/contacts/data/datasources/contact_local_datasource.dart';
import 'package:meta/meta.dart';

import '../../data/models/contact_model.dart';
import '../../domain/entities/contact.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactLocalDataSource localDataSource;

  ContactBloc(this.localDataSource) : super(ContactInitial()) {
    on<LoadContacts>((event, emit) async {
      emit(ContactLoading());
      try {
        final contacts = await localDataSource.getContacts();
        emit(ContactLoaded(contacts));
      } catch (e) {
        emit(ContactError(e.toString()));
      }
    });

    on<AddContact>((event, emit) async {
      try {
        final newContactModel = ContactModel.fromEntity(event.contact);
        await localDataSource.addContact(newContactModel);
        add(LoadContacts());
      } catch (e) {
        emit(ContactError(e.toString()));
      }
    });
  }
}
