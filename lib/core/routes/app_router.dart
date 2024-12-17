import 'package:ft_hangouts/features/contacts/domain/entities/contact.dart';
import 'package:ft_hangouts/features/contacts/presentation/pages/contact_form_page.dart';
import 'package:go_router/go_router.dart';
import 'package:ft_hangouts/features/contacts/presentation/pages/contact_list_page.dart';
import 'package:ft_hangouts/features/settings/presentation/pages/settings_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'contact_list',
      builder: (context, state) => const ContactListPage(),
    ),
    GoRoute(
      path: '/contact_form',
      name: 'contact_form',
      builder: (context, state) {
        final contact = state.extra as Contact?;
        return ContactFormPage(contact: contact);
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
