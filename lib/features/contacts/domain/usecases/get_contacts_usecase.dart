import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';
import 'package:ft_hangouts/features/contacts/domain/repositories/contact_repository.dart';

class GetContactsUseCase {
  final ContactRepository repository;

  GetContactsUseCase(this.repository);

  Future<List<Contact>> call() {
    return repository.getContacts();
  }
}
