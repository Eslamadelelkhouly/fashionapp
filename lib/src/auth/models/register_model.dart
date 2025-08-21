class RegisterModel {
  final String email;
  final String username;
  final String password;

  RegisterModel({
    required this.email,
    required this.username,
    required this.password,
  });

  // Convert JSON to RegisterModel
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Convert RegisterModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }
}