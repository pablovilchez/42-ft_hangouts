import 'package:sqflite/sqflite.dart';

import '../../models/contact_model.dart';

class ContactDataSource {
  Database? _database;

  Future<Database> getDatabase() async {
    _database ??= await _initDatabase('contacts.db');
    return _database!;
  }

  Future<Database> _initDatabase(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$dbName';

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        lastName TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL,
        address TEXT NOT NULL,
        photo TEXT NOT NULL
      )
    ''');
  }

  Future<void> addContact(ContactModel contactModel) async {
    final db = await getDatabase();
    await db.insert('contacts', contactModel.toMap());
  }

  Future<void> deleteContact(int id) async {
    final db = await getDatabase();
    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateContact(ContactModel contactModel) async {
    final db = await getDatabase();
    await db.update(
      'contacts',
      contactModel.toMap(),
      where: 'id = ?',
      whereArgs: [contactModel.id],
    );
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await getDatabase();
    final data = await db.query('contacts');
    return data.map((contact) => ContactModel.fromMap(contact)).toList();
  }
}