class ProfileModel {
  final int id;
  final String username;
  final String email;

  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
  });

  /// Factory constructor to create a ProfileModel from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  /// Convert ProfileModel to JSON (useful for sending data to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
