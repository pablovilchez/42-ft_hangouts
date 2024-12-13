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
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
