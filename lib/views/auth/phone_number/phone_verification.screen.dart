import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/config/providers.dart';
import 'package:loan_originator_poc/constants/utils.dart';
import 'package:loan_originator_poc/shared_widgets/custom_text_field.dart';

class PhoneVerificationScreen extends ConsumerWidget {
  final String verificationId;

  const PhoneVerificationScreen({Key key, this.verificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Phone number"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Utils.verticalSpacer(),
              CustomTextField(
                hintText: "Enter Verification Code",
                title: "Verification Code",
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  if (value.length == 6) {
                    _auth.signInWithCredential(
                        context,
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: value.toString()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
