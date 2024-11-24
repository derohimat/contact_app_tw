import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/app_colors.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 36.0),
            Text(
              "Hi There!",
              style: TextStyle(color: AppColors.blue, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please login to see your contact list!",
              style: TextStyle(color: AppColors.darkGray, fontSize: 15.0),
            ),
            const SizedBox(height: 36),
            RichText(
              text: TextSpan(
                text: 'User ID',
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller.idController,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.login,
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
