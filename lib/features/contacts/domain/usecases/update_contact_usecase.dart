import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';
import 'package:ft_hangouts/features/contacts/domain/repositories/contact_repository.dart';

class UpdateContactUseCase {
  final ContactRepository repository;

  UpdateContactUseCase(this.repository);

  Future<void> call(Contact contact) {
    return repository.updateContact(contact);
  }
}
