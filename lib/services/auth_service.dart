// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flexus_framework.dart';
import '../imports.dart';
import '../models/auth_user.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  var authUser = AuthUser().obs;
  var isEmailVerified = false.obs;

  Future<Map<String, dynamic>> getUser(String uuid) async {
    var values = new Map<String, dynamic>();
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(uuid).get();
    if (doc.exists) {
      values['gender'] =
          doc.data().toString().contains('gender') ? doc.get('gender') : null;
      values['dateOfBirth'] = doc.data().toString().contains('dateOfBirth')
          ? doc.get('dateOfBirth')
          : null;
    }
    return values;
  }

  Future<void> updateUser(
      String? uuid, Gender gender, DateTime? dateOfBirth) async {
    var values = new Map<String, dynamic>();
    values['gender'] = gender.toShortString();
    if (dateOfBirth != null) values['dateOfBirth'] = dateOfBirth;
    await FirebaseFirestore.instance.collection("users").doc(uuid).set(values);
  }

  Future<void> afterLogin() async {
    User user = FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> userData = await AuthService.to.getUser(user.uid);
    if (userData['gender'] != null)
      AuthService.to.authUser.value.gender =
          userData['gender'] == "male" ? Gender.male : Gender.female;
    if (userData['dateOfBirth'] != null)
      AuthService.to.authUser.value.dateOfBirth =
          userData['dateOfBirth'].toDate();
    await FlexusController.to.init?.afterAuthentication();
    Util.to.logger().d("Login Success");
  }

  void logout(Widget navigateToScreen) async {
    Util.to.showYesNoDialog(
        message: Trns.logout_confirmation.val,
        title: "",
        onYesPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Get.offAll(navigateToScreen);
            AuthService.to.isEmailVerified.value = false;
            AuthService.to.authUser = AuthUser().obs;
            Util.to.logger().i("User logged out");
          });
        });
  }
}
