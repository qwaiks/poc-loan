import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/config/providers.dart';
import 'package:loan_originator_poc/constants/utils.dart';
import 'package:loan_originator_poc/shared_widgets/custom_button.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({
    Key key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authProvider = ref.read(authenticationProvider);
    final userNotificationProvider = ref.read(notificationProvider);
    user = authProvider.getCurrentUser();
    userNotificationProvider.saveUserInfo(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authenticationProvider);
    final userNotificationProvider = ref.watch(notificationProvider);
    user = authProvider.getCurrentUser();
    //userNotificationProvider.saveUserInfo(user.uid);

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
                      text: user.phoneNumber,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))
                ])),
            Utils.verticalSpacer(),
            Row(
              children: [
                Flexible(
                  child: CustomButton(
                    text: "In App Notification ",
                    backgroundColor: Colors.green,
                    onPressed: () => userNotificationProvider
                        .saveNotificationText(user.uid, true),
                  ),
                ),
                Utils.horizontalSpacer(),
                Flexible(
                  child: CustomButton(
                    text: "Normal notification",
                    backgroundColor: Colors.deepOrange,
                    onPressed: () => userNotificationProvider
                        .saveNotificationText(user.uid, false),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
