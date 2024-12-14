import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/localization/app_localizations.dart';
import 'package:ft_hangouts/features/contacts/data/datasources/contact_local_datasource.dart';
import 'package:ft_hangouts/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:go_router/go_router.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contactBloc = ContactBloc(ContactLocalDataSource());
    return BlocConsumer<ContactBloc, ContactState>(
      bloc: contactBloc,
      listener: (context, state) {
        if (state is ContactError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context).translate('contacts_page_title')),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.push('/settings');
                },
              ),
            ],
          ),
          body: BlocProvider(
            create: (context) =>
                ContactBloc(ContactLocalDataSource())..add(LoadContacts()),
            child: BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                if (state is ContactLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ContactError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is ContactLoaded) {
                  final contacts = state.contacts;
                  return contacts.isEmpty
                      ? Center(
                          child: Text(AppLocalizations.of(context)
                              .translate('contacts_page_empty')),
                        )
                      : ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ListTile(
                              title: Text(contact.name),
                              subtitle: Text(contact.phone),
                            );
                          },
                        );
                } else {
                  return Center(
                    child: Text(AppLocalizations.of(context)
                        .translate('error_contacts_page')),
                  );
                }
              },
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              onPressed: () {
                context.push('/add_contact');
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
