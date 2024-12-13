class User {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  User({
    required this.id,
    required this.firstName,
    this.middleName = '',
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
