// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

class AuthUser {
  String? uuid;
  String? name;
  String? email;
  String? profilePicture;
  bool? isEmailVerified;
  Gender? gender;
  DateTime? dateOfBirth;
  AuthType? authType;
}

enum AuthType { facebook, google, apple, email }
enum Gender { male, female }

extension GenderParseToString on Gender {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
