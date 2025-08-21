class LoginModel {
  final String username;
  final String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  // Convert JSON to LoginModel
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Convert LoginModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
