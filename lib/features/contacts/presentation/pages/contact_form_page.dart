import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/localization/app_localizations.dart';
import 'package:ft_hangouts/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';

class ContactFormPage extends StatefulWidget {
  final Contact? contact;

  const ContactFormPage({super.key, this.contact});

  @override
  ContactFormPageState createState() => ContactFormPageState();
}

class ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _lastNameController.text = widget.contact!.lastName;
      _phoneController.text = widget.contact!.phone;
      _emailController.text = widget.contact!.email;
      _addressController.text = widget.contact!.address;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedContact = Contact(
        id: widget.contact?.id,
        name: _nameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
      );

      if (widget.contact == null) {
        context.read<ContactBloc>().add(AddContact(updatedContact));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context).translate('contact_added')),
          ),
        );
      } else {
        context.read<ContactBloc>().add(UpdateContact(updatedContact));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context).translate('contact_updated')),
          ),
        );
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('form_page_title')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context).translate('contact_name')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('form_required');
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .translate('contact_last_name')),
                        ),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .translate('contact_phone')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .translate('form_required');
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
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
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.redAccent),
                              ),
                              onPressed: Navigator.of(context).pop,
                              child: Text(
                                  AppLocalizations.of(context).translate('text_cancel')),
                            ),
                            const SizedBox(width: 20),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.greenAccent),
                              ),
                              onPressed: _submitForm,
                              child: Text(
                                  AppLocalizations.of(context).translate('text_save')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
