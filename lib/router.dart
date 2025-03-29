import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/screens/chat_section/chat_list_screen.dart';
import 'package:frappe_flutter_app/screens/chat_section/chat_screen.dart';
import 'package:frappe_flutter_app/screens/home%20section/home_screen.dart';
import 'package:frappe_flutter_app/screens/onboarding_screens/interst_screen.dart';
import 'package:frappe_flutter_app/screens/onboarding_screens/login_screen.dart';
import 'package:frappe_flutter_app/screens/onboarding_screens/signup_screen.dart';
import 'package:frappe_flutter_app/screens/onboarding_screens/splash_screen.dart';
import 'package:frappe_flutter_app/screens/onboarding_screens/upload_screen.dart';
import 'package:frappe_flutter_app/screens/premium_section/premium_feature_screen.dart';
import 'package:frappe_flutter_app/screens/profile_section/my_profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'constants/routes_constant.dart';
import 'providers/auth_provider.dart';
import "services/logger_service.dart";
import 'utils/utils.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteConstants.splash,
  refreshListenable: AuthProvider(),
  redirect: (context, state) async {
    logger.info('Redirecting to: ${state.path}');

    final isAuthenticated = await Utils.checkAuthentication();
    logger.info('User authenticated: $isAuthenticated');

    if (!isAuthenticated && state.path != RouteConstants.login) {
      logger.info('Redirecting to login...');
      return RouteConstants.login;
    }

    logger.info('Allowing navigation to: ${state.path}');
    return null;
  },
  routes: <GoRoute>[
    GoRoute(
      path: RouteConstants.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.signup,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.upload,
      builder: (BuildContext context, GoRouterState state) {
        return const UploadPhotoScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.interest,
      builder: (BuildContext context, GoRouterState state) {
        return const InterstScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.chat,
      builder: (BuildContext context, GoRouterState state) {
        return const ChatScreen(
          contactName: '',
        );
      },
    ),
    GoRoute(
      path: RouteConstants.premium,
      builder: (BuildContext context, GoRouterState state) {
        return const PremiumFeatureScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.messagesList,
      builder: (BuildContext context, GoRouterState state) {
        return const MessagesListScreen();
      },
    ),
    GoRoute(
      path: RouteConstants.myprofile,
      builder: (BuildContext context, GoRouterState state) {
        return  MyProfileScreen();
      },
    ),
  ],
);
