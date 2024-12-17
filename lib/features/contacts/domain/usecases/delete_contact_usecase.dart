import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';
import 'package:ft_hangouts/features/contacts/domain/repositories/contact_repository.dart';

class DeleteContactUseCase {
  final ContactRepository repository;

  DeleteContactUseCase(this.repository);

  Future<void> call(Contact contact) {
    return repository.deleteContact(contact);
  }
}
