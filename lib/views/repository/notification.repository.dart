import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_originator_poc/config/firestore_paths.dart';
import 'package:loan_originator_poc/config/providers.dart';
import 'package:loan_originator_poc/constants/utils.dart';

abstract class BaseNotificationRepository {
  Future<void> saveUserInfo(String uid);

  Future<void> saveNotificationText(String uid, bool isInApp);

  Future<List<dynamic>> getAllNotifications();

  Future<List<dynamic>> getUserNotifications(String uid);
}

class NotificationRepository extends BaseNotificationRepository {
  final Reader _read;

  NotificationRepository(this._read);

  @override
  Future<List> getAllNotifications() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveNotificationText(String uid, bool isInApp) async {
    // TODO: implement saveNotificationText
    final fireStore = _read(fireStoreProvider);
    final uid = _read(firebaseAuthProvider).currentUser.uid;
    final path = FireStorePath.userNotification.replaceAll(":uid", uid);
    final deviceId = await Utils().getId();
    final fcmToken = await Utils().getFCMToken();

    final data = {
      "isInApp": isInApp,
      "timeStamp": DateTime.now().toString(),
      'deviceId': deviceId,
      'fcmToken': fcmToken
    };
    try {
      //await fireStore.collection(path).doc().set(data);
      await fireStore
          .collection(FireStorePath.generalNotifications)
          .doc()
          .set(data);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> saveUserInfo(String uid) async {
    final fireStore = _read(fireStoreProvider);
    final uid = _read(firebaseAuthProvider).currentUser.uid;
    final deviceId = await Utils().getId();
    try {
      await fireStore
          .collection(FireStorePath.users)
          .doc(uid)
          .set({"deviceId": deviceId});
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List> getUserNotifications(String uid) {
    // TODO: implement getUserNotifications
    throw UnimplementedError();
  }
}
