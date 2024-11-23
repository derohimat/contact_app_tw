class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String dob;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email = '',
    this.dob = '',
  });

  // Factory constructor to create a Contact from JSON
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'] ?? '',
      // Handle null values
      dob: json['dob'] ?? '', // Handle null values
    );
  }
}
