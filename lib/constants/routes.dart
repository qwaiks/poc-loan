import 'package:flutter/material.dart';
import 'package:loan_originator_poc/config/router.dart';
import 'package:loan_originator_poc/views/auth/phone_number/phone_auth.screen.dart';
import 'package:loan_originator_poc/views/auth/phone_number/phone_verification.screen.dart';
import 'package:loan_originator_poc/views/dashboard/dashboard.screen.dart';
import 'package:loan_originator_poc/views/landing.screen.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.landingRoute:
      return MaterialPageRoute(builder: (context) => const LandingScreen());
    case AppRoutes.phoneNumberAuthenticationRoute:
      return MaterialPageRoute(builder: (context) => const PhoneAuthScreen());
    case AppRoutes.phoneNumberVerificationRoute:
      return MaterialPageRoute(builder: (context) =>  PhoneVerificationScreen(verificationId: settings.arguments,));
    case AppRoutes.dashboardRoute:
      return MaterialPageRoute(builder: (context) => const DashboardScreen());
    default:
      return MaterialPageRoute(builder: (context) => const PhoneAuthScreen());
  }
}
