import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/localization/app_localizations.dart';
import 'package:ft_hangouts/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _photoController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final phone = _phoneController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final address = _addressController.text;
      final photo = _photoController.text;
      final newContact = Contact(
        name: name,
        phone: phone,
        lastName: '',
        email: '',
        address: '',
        photo: '',
      );

      context.read<ContactBloc>().add(AddContact(newContact));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('form_page_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('contact_name')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('error_bad_name');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('contact_phone')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('error_bad_phone');
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('contact_last_name')),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('contact_email')),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('contact_address')),
              ),
              TextFormField(
                controller: _photoController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('contact_photo')),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child:
                    Text(AppLocalizations.of(context).translate('text_save')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
