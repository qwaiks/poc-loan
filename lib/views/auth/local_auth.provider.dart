import 'package:flutter_riverpod/flutter_riverpod.dart';
String phoneNumber;
String verificationCode;
String countryCode = "+233";

final countryCodeProvider = StateProvider<String>((ref) {
  return countryCode;
});

final phoneProvider = StateProvider<String>((ref) {
  return phoneNumber;
});

final verificationProvider = StateProvider<String>((ref) {
  return verificationCode ;
});
