import '../../domain/entities/contact.dart';

class ContactModel extends Contact {
  ContactModel({
    required super.id,
    required super.name,
    required super.lastName,
    required super.phone,
    required super.email,
    required super.address,
    required super.photo,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      photo: map['photo'],
    );
  }

  factory ContactModel.fromEntity(Contact contact) {
    return ContactModel(
      id: contact.id,
      name: contact.name,
      lastName: contact.lastName,
      phone: contact.phone,
      email: contact.email,
      address: contact.address,
      photo: contact.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'address': address,
      'photo': photo,
    };
  }

  Contact toEntity() {
    return Contact(
      id: id,
      name: name,
      lastName: lastName,
      phone: phone,
      email: email,
      address: address,
      photo: photo,
    );
  }
}
