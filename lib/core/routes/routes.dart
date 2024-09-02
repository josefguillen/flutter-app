import 'package:flutterexamapp/features/presentation/user_details_screen/user_details_screen.dart';
import 'package:flutterexamapp/features/presentation/user_list_screen/user_list_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  Routes._();

  static final routers = GoRouter(
    initialLocation: UserListScreen.routeName,
    routes: [
      GoRoute(
        path: UserListScreen.routeName,
        name: UserListScreen.routeName,
        builder: (_, __) {
          return const UserListScreen();
        },
      ),
      GoRoute(
        path: UserDetailsScreen.routeName,
        name: UserDetailsScreen.routeName,
        builder: (_, __) {
          return const UserDetailsScreen();
        },
      ),
    ],
  );
}