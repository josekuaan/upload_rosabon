
class ApiErrorModel {

  late int code;
  Error? error;
  late String message;
  bool success;

  ApiErrorModel({
    required this.code,
    this.error,
    required this.message,
    this.success = false,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
    code: json["code"],
    error: json["error"] != null ? Error.fromJson(json["error"]) : null,
    message: json["message"],
  );
}


class Error {
  String? devMessage;
  String? possibleSolution;
  String? exceptionError;
  List<dynamic>? validationError;
  late String userMessage;
  int? errorCode;
  int? statusCode;

  Error({
    this.devMessage,
    this.possibleSolution,
    this.exceptionError,
    this.validationError,
    this.userMessage = "Oops an Error occurred please try again later",
    this.errorCode,
    this.statusCode,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    devMessage: json["devMessage"],
    possibleSolution: json["possibleSolution"],
    exceptionError: json["exceptionError"],
    // validationError: List<dynamic>.from(json["validationError"].map((x) => x)),
    userMessage: json["userMessage"],
    errorCode: json["errorCode"],
    statusCode: json["statusCode"],
  );
}
