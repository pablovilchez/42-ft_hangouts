import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';
import 'package:ft_hangouts/features/contacts/domain/repositories/contact_repository.dart';

class AddContactUseCase {
  final ContactRepository repository;

  AddContactUseCase(this.repository);

  Future<void> call(Contact contact) {
    return repository.addContact(contact);
  }
}
