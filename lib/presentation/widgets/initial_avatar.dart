import 'package:contact_app_tw/styles/app_colors.dart';
import 'package:flutter/material.dart';

class InitialAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;
  final double size;
  final double textSize;
  final bool isAddContactMode;

  const InitialAvatar({
    super.key,
    required this.firstName,
    required this.lastName,
    this.size = 47.0, // Default size
    this.textSize = 20.0, // Default text size
    this.isAddContactMode = false,
  });

  @override
  Widget build(BuildContext context) {
    String initials = '';
    if (firstName.isNotEmpty) initials += firstName[0];
    if (lastName.isNotEmpty) initials += lastName[0];

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.darkGray,
          width: 1.0,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: size / 2,
        child: isAddContactMode
            ? Icon(Icons.person_outline, color: Colors.white, size: textSize)
            : Text(
                initials.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize,
                ),
              ),
      ),
    );
  }
}
