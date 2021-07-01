// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../imports.dart';
import '../../models/auth_user.dart';
import '../../services/auth_service.dart';

class FxProfileController extends GetxController {
  var isLoading = false.obs;
  Rx<File> imageFile = File("").obs;

  Future<void> updateProfile(GlobalKey<FormBuilderState> formKey) async {
    if (formKey.currentState!.validate()) {
      String? name = formKey.currentState!.fields['name']?.value?.trim();
      String? password = formKey.currentState!.fields['password']?.value;
      Gender gender =
          formKey.currentState!.fields['gender']?.value == "male" ? Gender.male : Gender.female;
      DateTime? dateOfBirth = formKey.currentState!.fields['date_of_birth']?.value;

      User user = FirebaseAuth.instance.currentUser!..reload();

      if (password != null) {
        await user.updatePassword(password);
      }

      if (imageFile.value.path != "") {
        var firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('user/profile/${AuthService.to.authUser.value.uuid}.jpg');
        await firebaseStorageRef.putFile(imageFile.value);
        String photoURL = await firebaseStorageRef.getDownloadURL();
        await user.updatePhotoURL(photoURL);
      }

      await user.updateDisplayName(name);
      user = FirebaseAuth.instance.currentUser!
        ..reload().then((value) {
          AuthService.to.authUser.value.name = name;
          AuthService.to.authUser.value.profilePicture = user.photoURL;
          imageFile.value = File("");
          if (AuthService.to.authUser.value.gender == null ||
              AuthService.to.authUser.value.dateOfBirth == null) {
            AuthService.to.updateUser(AuthService.to.authUser.value.uuid, gender, dateOfBirth);
            if (gender != null) AuthService.to.authUser.value.gender = gender;
            if (dateOfBirth != null) AuthService.to.authUser.value.dateOfBirth = dateOfBirth;
          }
          isLoading.value = false;
          Get.back();
        });
    } else {
      isLoading.value = false;
      Util.to.logger().e("Validation Failed");
    }
  }
}
