import '../utilities/imports/generalImport.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: false,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) {
        return '/mainApp';
      },
    ),
    GoRoute(
      name: mainAppRoute,
      path: '/mainApp',
      redirect: (BuildContext context, GoRouterState state) async {
        final prefs = await SharedPreferences.getInstance();
        bool onboarded = prefs.getBool(onboardedKey) ?? false;

        if (onboarded == true) {
          return '/login';
        } else {
          return '/onboarding';
        }
      },
    ),
    GoRoute(
      name: splashRoute,
      path: '/splash',
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const SplashScreen()),
    ),
    GoRoute(
      name: homeRoute,
      path: '/home',
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const Home()),
      routes: [],
    ),
    GoRoute(
      name: signupRoute,
      path: '/signup',
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const SignupScreen()),
      routes: [],
    ),
    GoRoute(
      name: loginRoute,
      path: '/login',
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const LoginScreen()),
      routes: [
        GoRoute(
          name: forgotPasswordRoute,
          path: 'forgotPassword',
          pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: const ForgotPassword()),
        ),
        GoRoute(
          name: verifyIdentityRoute,
          path: 'verifyIdentity',
          pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: const VerifyIdentity()),
        ),
        GoRoute(
          name: createPasswordRoute,
          path: 'createPassword',
          pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: const CreatePassword()),
        ),
      ],
    ),
    GoRoute(
      name: onboardingRoute,
      path: '/onboarding',
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const OnboardingPage()),
    )
  ],
);
