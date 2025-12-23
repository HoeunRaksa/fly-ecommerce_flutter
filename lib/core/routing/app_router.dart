import 'package:fly/core/routing/app_routes.dart';
import 'package:fly/features/auth/login/ui/login_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter router(AuthProvider authProvider) => GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
      redirect: (context, state) {
        final loggedIn = authProvider.isLoggedIn;
        final currentPath = state.uri.path;
        if (loggedIn && currentPath == AppRoutes.login) return AppRoutes.home;
        if (!loggedIn && currentPath == AppRoutes.home) return AppRoutes.login;
        return null;
      },
  );
}
