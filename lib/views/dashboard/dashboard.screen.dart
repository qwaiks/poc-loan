import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/config/providers.dart';
import 'package:loan_originator_poc/constants/utils.dart';
import 'package:loan_originator_poc/shared_widgets/custom_button.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authRepositoryProvider);

    final user = authProvider.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Utils.verticalSpacer(),
            Text.rich(TextSpan(
                text: "Hello ",
                style: const TextStyle(
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                      text: user.uid,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))
                ])),
            Utils.verticalSpacer(),
            CustomButton(
              text: "Send new notification",
              onPressed: () {},
            ),
            Utils.verticalSpacer(),
          ],
        ),
      )),
    );
  }
}
