import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  FirebaseMessaging firebaseMessaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseMessaging = FirebaseMessaging.instance;
    final authProvider = ref.read(authenticationProvider);
    final userNotificationProvider = ref.read(notificationProvider);
    user = authProvider.getCurrentUser();
    userNotificationProvider.saveUserInfo(user.uid);
    FirebaseMessaging.onMessage.listen((event) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "New Notification", style: TextStyle(fontSize: 16),),
              content: Text(event.notification.body),
              actions: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
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
          IconButton(onPressed: () =>authProvider.signOut(), icon: const Icon(Icons.exit_to_app))
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
                        onPressed: () =>
                            userNotificationProvider
                                .saveNotificationText(user.uid, true),
                      ),
                    ),
                    Utils.horizontalSpacer(),
                    Flexible(
                      child: CustomButton(
                        text: "Normal notification",
                        backgroundColor: Colors.deepOrange,
                        onPressed: ()  {

                          userNotificationProvider
                              .saveNotificationText(user.uid, false);
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }

                        }
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
