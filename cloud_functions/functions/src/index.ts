import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.firestore
    .document("notifications/{notification_id}")
    .onWrite((event) => {
      const body = "New notification at " + event.after.get("timeStamp");
      const fcmToken = event.after.get("fcmToken");

      const payload = {
        notification: {
          body: body,
        },
      };

      return admin
          .messaging()
          .sendToDevice(fcmToken, payload)
          .then((res) => {
            console.log("notification sent ");
          })
          .catch((err) => {
            console.log("notification sent " + err);
          });
    });
