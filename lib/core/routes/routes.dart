import 'package:flutterexamapp/features/presentation/person_details_screen/person_details_screen.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/person_list_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  Routes._();

  static final routers = GoRouter(
    initialLocation: PersonListScreen.routeName,
    routes: [
      GoRoute(
        path: PersonListScreen.routeName,
        name: PersonListScreen.routeName,
        builder: (_, __) {
          return const PersonListScreen();
        },
      ),
      GoRoute(
        path: PersonDetailsScreen.routeName,
        name: PersonDetailsScreen.routeName,
        builder: (_, __) {
          return const PersonDetailsScreen();
        },
      ),
    ],
  );
}