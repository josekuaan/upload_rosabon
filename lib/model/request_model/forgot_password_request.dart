class ForgotPasswordRequest {
  String? email;

  ForgotPasswordRequest({this.email});

  ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["email"] = email;
    return data;
  }
}

class ChangePasswordRequest {
  String? newPassword;
  String? oldPassword;
  String? otp;

  ChangePasswordRequest({this.newPassword, this.oldPassword, this.otp});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    newPassword = json["newPassword"];
    oldPassword = json["oldPassword"];
    otp = json["otp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["newPassword"] = newPassword;
    data["oldPassword"] = oldPassword;
    data["otp"] = otp;
    return data;
  }
}
