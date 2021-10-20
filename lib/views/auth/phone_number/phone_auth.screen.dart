import 'package:flutter/material.dart';
import 'package:loan_originator_poc/constants/utils.dart';
import 'package:loan_originator_poc/shared_widgets/custom_button.dart';
import 'package:loan_originator_poc/shared_widgets/phone_no_input.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Text(
            "Enter phone number",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Utils.verticalSpacer(),
          PhoneNoInput(
            onChanged: (value) {},
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
          CustomButton(text: "Continue", onPressed: () {}),
        ],
      ),
    );
  }
}
