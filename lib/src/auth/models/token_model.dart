class TokenModel {
  final String authToken;

  TokenModel({required this.authToken});

  // Convert JSON to TokenModel
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      authToken: json['auth_token'] ?? '',
    );
  }

  // Convert TokenModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'auth_token': authToken,
    };
  }
}
