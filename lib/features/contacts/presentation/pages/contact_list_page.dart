import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/features/contacts/data/datasources/contact_local_datasource.dart';
import 'package:ft_hangouts/features/contacts/presentation/bloc/contact_bloc.dart';

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
            title: const Text('Contacts'),
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
                      ? const Center(
                          child: Text('No contacts found'),
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
                  return const Center(
                    child: Text('No contacts found'),
                  );
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
