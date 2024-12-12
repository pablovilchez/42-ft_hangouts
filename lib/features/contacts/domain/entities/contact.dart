class Contact {
  final int? id;
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String address;
  final String photo;

  Contact({
    this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.address,
    required this.photo,
  });
}