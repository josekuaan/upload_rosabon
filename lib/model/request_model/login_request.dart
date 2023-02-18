import 'package:rosabon/model/response_models/base_response.dart';

class Loginrequest extends BaseResponse {
  String? email;
  String? password;
  String? platformType;
  String? platform;
  Loginrequest(
      {required this.email, this.password, this.platformType, this.platform});
  Loginrequest.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
    platformType = json["platformType"];
    platform = json["platform"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["email"] = email;
    data["password"] = password;
    data["platformType"] = platformType;
    data["platform"] = platform;
    return data;
  }
}
