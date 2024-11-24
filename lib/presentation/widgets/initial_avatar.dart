import 'package:flutter/material.dart';

class InitialAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;

  const InitialAvatar({
    Key? key,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initials = '';
    if (firstName.isNotEmpty) initials += firstName[0];
    if (lastName.isNotEmpty) initials += lastName[0];

    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
