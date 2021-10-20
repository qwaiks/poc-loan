
import 'package:flutter/material.dart';

class AppRoutes{

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String phoneNumberAuthenticationRoute  = "phone_number_authentication";
  static const String phoneNumberVerificationRoute  = "phone_number_verification";
  static const String notificationRoute = "notification_route";
  static const String dashboardRoute ="dashboard_route";
  static const String landingRoute ="landing_route";
}