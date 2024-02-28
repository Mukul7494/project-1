class UserProfile {
  String email;
  String firstName;
  String? lastName;
  int userRole;

  UserProfile({
    required this.email,
    required this.firstName,
    this.lastName,
    required this.userRole,
  });

  factory UserProfile.fromJson(Map<String, dynamic> userJson) {
    return UserProfile(
      email: userJson["email"],
      firstName: userJson["first_name"],
      lastName: userJson["last_name"],
      userRole: userJson["role"],
    );
  }
}
