import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/config/providers.dart';
import 'package:loan_originator_poc/constants/utils.dart';
import 'package:loan_originator_poc/shared_widgets/custom_button.dart';
import 'package:loan_originator_poc/shared_widgets/phone_no_input.dart';
import 'package:loan_originator_poc/views/auth/local_auth.provider.dart';

class PhoneAuthScreen extends ConsumerWidget {
  const PhoneAuthScreen({Key key}) : super(key: key);

  void updatePhoneNumber(WidgetRef ref, String value,
      {bool isCountryCode = false}) {
    if (!isCountryCode) {
      ref.read(phoneProvider).state = value;
    } else {
      ref.read(countryCodeProvider).state = value;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneProvider).state;
    final countryCode = ref.watch(countryCodeProvider).state;
    final _auth = ref.watch(authRepositoryProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ListView(
            children: [
              const Text(
                "Enter phone number",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Utils.verticalSpacer(),
              PhoneNoInput(
                onChangedCountryCode: (value) =>
                    updatePhoneNumber(ref, value.toString(), isCountryCode: true),
                onChangedTextField: (value) => updatePhoneNumber(
                  ref,
                  value.toString(),
                ),
                title: "Phone number",
                hintText: "Enter phone number",
                validator: (value) {
                  if (value.length < 8) {
                    return "Field should b more than 8 characters";
                  }
                  return null;
                },
              ),
              Utils.verticalSpacer(),
              CustomButton(
                  text: "Continue",
                  onPressed: () =>
                      _auth.phoneNumberVerification(context,"$countryCode$phoneNumber")),
            ],
          ),
        ),
      ),
    );
  }
}
