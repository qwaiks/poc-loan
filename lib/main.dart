import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/constants/routes.dart' as router;
import 'package:loan_originator_poc/views/auth/phone_number/phone_auth.screen.dart';
import 'package:loan_originator_poc/views/dashboard/dashboard.screen.dart';

import 'config/providers.dart';
import 'config/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    //final authStateChanges = ref.watch(authStateChangesProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const AuthChecker(),
      onGenerateRoute: router.generateRoute,
      navigatorKey: AppRoutes().navigatorKey,
      //initialRoute: AppRoutes.phoneNumberAuthenticationRoute,
    );
  }
}

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateChangesProvider);
    return _authState.when(
      data: (value) {
        if (value != null) {
          return const DashboardScreen();
        }
        return const PhoneAuthScreen();
      },
      loading: (_)  {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (_, __, ___) {
        return const Scaffold(
          body: Center(
            child: Text("OOPS"),
          ),
        );
      },
    );
  }
}

