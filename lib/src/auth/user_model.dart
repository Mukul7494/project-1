class User {
  User({
    required this.uid,
    required this.email,
    this.fullName,
    required this.role,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid']! as String,
          email: json['email']! as String,
          fullName: json['name']! as String,
          role: json['role']! as String,
        );

  final String uid;
  final String email;
  final String? fullName;
  final String role;

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
    };
  }
}
