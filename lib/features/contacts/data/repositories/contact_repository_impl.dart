import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_local_datasource.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDataSource contactDataSource;

  ContactRepositoryImpl({required this.contactDataSource});

  @override
  Future<List<Contact>> getContacts() async {
    final contactModelList = await contactDataSource.getContacts();
    return contactModelList.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addContact(Contact contact) async {
    final contactModel = ContactModel.fromEntity(contact);
    await contactDataSource.addContact(contactModel);
  }

  @override
  Future<void> deleteContact(Contact contact) async {
    final contactModel = ContactModel.fromEntity(contact);
    await contactDataSource.deleteContact(contactModel.id!);
  }

  @override
  Future<void> updateContact(Contact contact) async {
    final contactModel = ContactModel.fromEntity(contact);
    await contactDataSource.updateContact(contactModel);
  }
}