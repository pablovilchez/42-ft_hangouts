import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_hangouts/core/localization/app_localizations.dart';
import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';
import 'package:ft_hangouts/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:go_router/go_router.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage('assets/images/default_avatar.jpg'), context);
    return BlocConsumer<ContactBloc, ContactState>(
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
          body: _buildBody(context, state),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              onPressed: () {
                context.push('/contact_form');
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

Widget _buildBody(BuildContext context, ContactState state) {
  if (state is ContactLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else if (state is ContactError) {
    return Center(
      child: Text(state.message),
    );
  } else if (state is ContactsLoaded) {
    final contacts = state.contacts;
    contacts.sort((a, b) => a.name.compareTo(b.name));
    return contacts.isEmpty
        ? Center(
            child: Text(
                AppLocalizations.of(context).translate('contacts_page_empty')),
          )
        : ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/images/default_avatar.jpg')),
                title: Text('${contact.name} ${contact.lastName}',
                    style: const TextStyle(fontSize: 18)),
                subtitle: Text(contact.phone),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('${contact.name} ${contact.lastName}',
                                style: const TextStyle(fontSize: 24)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.people),
                            title: Text(AppLocalizations.of(context)
                                .translate('action_view')),
                            onTap: () {
                              _showContactDetails(context, contact);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.call),
                            title: Text(AppLocalizations.of(context)
                                .translate('action_call')),
                            onTap: () {
                              // call the contact
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.message),
                            title: Text(AppLocalizations.of(context)
                                .translate('action_send_message')),
                            onTap: () {
                              // send a message to the contact
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: Text(AppLocalizations.of(context)
                                .translate('action_edit')),
                            onTap: () {
                              Navigator.of(context).pop();
                              context.push(
                                '/contact_form',
                                extra: contact,
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: Text(AppLocalizations.of(context)
                                .translate('action_delete')),
                            onTap: () {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                        .translate('action_confirm_delete')),
                                    content: Text(
                                        '${contact.name} ${contact.lastName}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(AppLocalizations.of(context)
                                            .translate('text_cancel')),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          context.read<ContactBloc>().add(
                                                DeleteContact(contact),
                                              );
                                        },
                                        child: Text(AppLocalizations.of(context)
                                            .translate('action_delete')),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
  } else {
    return Center(
      child:
          Text(AppLocalizations.of(context).translate('error_contacts_page')),
    );
  }
}

void _showContactDetails(BuildContext context, Contact contact) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final isLandScape = constraints.maxWidth > constraints.maxHeight;
          return DraggableScrollableSheet(
            initialChildSize: isLandScape ? 0.3 : 0.7,
            minChildSize: isLandScape ? 0.3 : 0.7,
            maxChildSize: isLandScape ? 0.7 : 0.8,
            builder: (_, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/default_avatar.jpg'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${contact.name} ${contact.lastName}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      contact.phone,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const Divider(height: 30),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(contact.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: Text(contact.address),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate('text_back'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
