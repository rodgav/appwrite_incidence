import 'package:appwrite_incidence/app/app_preferences.dart';
import 'package:appwrite_incidence/app/dependency_injection.dart';
import 'package:appwrite_incidence/intl/generated/l10n.dart';
import 'package:appwrite_incidence/presentation/forgot_password/forgot_password.dart';
import 'package:appwrite_incidence/presentation/login/login.dart';
import 'package:appwrite_incidence/presentation/main/main.dart';
import 'package:appwrite_incidence/presentation/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
}

class RouteGenerator {
  static final AppPreferences _appPreferences = instance<AppPreferences>();

  static final router = GoRouter(
      routes: [
        GoRoute(
            path: Routes.splashRoute,
            builder: (context, state) {
              return const SplashView();
            }),
        GoRoute(
            path: Routes.loginRoute,
            builder: (context, state) {
              initLoginModule();
              return const LoginView();
            }),
        GoRoute(
            path: Routes.forgotPasswordRoute,
            builder: (context, state) {
              initForgotModule();
              return const ForgotPasswordView();
            }),
        GoRoute(
            path: Routes.mainRoute,
            builder: (context, state) {
              initMainModule();
              initIncidencesModule();
              initAreasModule();
              initUsersModule();
              return const MainView();
            }),
      ],
      errorBuilder: (context, state) => unDefinedRoute(context),
      initialLocation: Routes.splashRoute,
      debugLogDiagnostics: true,
      redirect: (state) {
        final loggedIn = _appPreferences.getSessionId() != '';
        final loggingIn = state.subloc == Routes.splashRoute ||
            state.subloc == Routes.loginRoute;
        if (!loggedIn) return loggingIn ? null : Routes.splashRoute;
        if (loggingIn) return Routes.mainRoute;
        return null;
      });

  static unDefinedRoute(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.noRouteFound),
      ),
      body: Center(child: Text(s.noRouteFound)),
    );
  }
}
